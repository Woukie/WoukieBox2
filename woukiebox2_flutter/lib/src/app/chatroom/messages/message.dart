import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:woukiebox2/src/app/profile/profile_pic.dart';
import 'package:woukiebox2/src/app/profile/profile_preview.dart';
import 'package:woukiebox2/src/util/hex_color.dart';
import 'package:woukiebox2/src/util/written_message.dart';

UserClient unknownUser = UserClient(
  id: -1,
  username: "Unknown User",
  bio: "",
  colour: "#FF0000",
  image: "",
  verified: false,
  visible: false,
);

class Message extends StatelessWidget {
  const Message({super.key, required this.messages, required this.index});

  final List<dynamic> messages;
  final int index;

  @override
  Widget build(BuildContext context) {
    final message = messages[index];
    final parentMessage =
        index != messages.length - 1 ? messages[index + 1] : null;

    if (message is WrittenGlobalMessage) {
      bool typeMatch = parentMessage is WrittenGlobalMessage;

      bool child = typeMatch && parentMessage.senderId == message.senderId;

      return child
          ? ChildMessage(
              message: message.message,
            )
          : HeadMessage(
              senderId: message.senderId,
              message: message.message,
              color: message.colour,
              image: message.image,
              username: message.username,
            );
    }

    if (message is WrittenChatMessage) {
      bool typeMatch = parentMessage is WrittenChatMessage;

      bool child = typeMatch && parentMessage.senderId == message.senderId;

      return child
          ? ChildMessage(message: message.message)
          : HeadMessage(senderId: message.senderId, message: message.message);
    }

    if (message is WrittenLeaveMessage) {
      return SystemMessageWrapper(
        child: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(
              text: message.username,
              style: TextStyle(
                color: HexColor.fromHex(message.colour),
              ),
            ),
            const TextSpan(
              text: " left the chat",
            ),
          ],
        ),
      );
    }

    if (message is WrittenJoinMessage) {
      return SystemMessageWrapper(
        child: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(
              text: message.username,
              style: TextStyle(
                color: HexColor.fromHex(message.colour),
              ),
            ),
            const TextSpan(
              text: " joined the chat",
            ),
          ],
        ),
      );
    }

    if (message is WrittenProfileMessage) {
      return SystemMessageWrapper(
        child: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(
              text: message.oldUsername,
              style: TextStyle(
                color: HexColor.fromHex(message.oldColour),
              ),
            ),
            const TextSpan(text: " is now known as "),
            TextSpan(
              text: message.newUsername ?? message.oldUsername,
              style: TextStyle(
                  color:
                      HexColor.fromHex(message.newColour ?? message.oldColour)),
            ),
          ],
        ),
      );
    }

    // This literally cannot happen
    return const Text("unknown chat message :)");
  }
}

class SystemMessageWrapper extends StatelessWidget {
  final TextSpan child;

  const SystemMessageWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
        child: Card(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontStyle: FontStyle.italic),
                children: [
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeadMessage extends StatelessWidget {
  final int senderId;
  final String? username, image, color;
  final String message;

  const HeadMessage({
    super.key,
    required this.senderId,
    required this.message,
    this.image,
    this.username,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);
    UserClient? user = appStateProvider.users[senderId];

    if (user == null) {
      appStateProvider.scheduleGetUser(senderId);
    }

    user ??= UserClient(
      id: senderId,
      username: "Loading...",
      bio: "",
      colour: Theme.of(context).primaryTextTheme.bodyMedium!.color!.toHex(),
      image: "",
      verified: false,
      visible: false,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: ProfilePreview(
              user: user,
              child: ProfilePic(
                url: image ?? user.image,
                offline: false,
                showIndicator: false,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username ?? user.username,
                  style: TextStyle(
                    color: HexColor.fromHex(color ?? user.colour),
                  ),
                ),
                Text(message),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChildMessage extends StatelessWidget {
  final String message;

  const ChildMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Container(
            width: 40,
          ),
        ),
        Expanded(
          child: Text(
            message,
          ),
        ),
      ],
    );
  }
}
