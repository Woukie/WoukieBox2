import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:woukiebox2_flutter/src/app/profile_pic.dart';
import 'package:woukiebox2_flutter/src/app/profile_preview.dart';
import 'package:woukiebox2_flutter/src/providers/connection_state_provider.dart';
import 'package:woukiebox2_flutter/src/util/hex_color.dart';
import 'package:woukiebox2_flutter/src/util/written_message.dart';

User unknownUser = User(
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
    final parentMessage = index != 0 ? messages[index - 1] : null;

    if (message is WrittenMessage) {
      bool typeMatch = parentMessage is WrittenMessage;

      bool child = typeMatch && parentMessage.senderId == message.senderId;

      return child
          ? ChildMessage(message: messages[index])
          : HeadMessage(message: messages[index]);
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
  const HeadMessage({super.key, required this.message});

  final WrittenMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: ProfilePreview(
              user: Provider.of<ConnectionStateProvider>(context)
                  .users[message.senderId]!,
              child: ProfilePic(
                url: message.image,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.username,
                  style: TextStyle(color: HexColor.fromHex(message.colour)),
                ),
                Text(message.message),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChildMessage extends StatelessWidget {
  const ChildMessage({super.key, required this.message});

  final WrittenMessage message;

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
            message.message,
          ),
        ),
      ],
    );
  }
}
