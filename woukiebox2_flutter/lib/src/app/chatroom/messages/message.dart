import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
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

  static String getTimestamp(DateTime time) {
    String prefix = "Today";

    DateTime now = DateTime.now().toUtc();
    bool sentToday =
        time.day == now.day && time.month == now.month && time.year == now.year;

    if (!sentToday) {
      prefix = "Yesterday";

      DateTime yesterday =
          DateTime.now().subtract(const Duration(days: 1)).toUtc();
      bool sentYesterday = time.day == yesterday.day &&
          time.month == yesterday.month &&
          time.year == yesterday.year;

      if (!sentYesterday) {
        prefix = DateFormat('EEE, MMM d, yyyy').format(time.toLocal());
      }
    }

    return '$prefix at ${DateFormat('h:mm a').format(time.toLocal())}';
  }

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
              sentAt: message.sentAt,
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
          : HeadMessage(
              senderId: message.senderId,
              sentAt: message.sentAt,
              message: message.message,
            );
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
  final DateTime sentAt;

  const HeadMessage({
    super.key,
    required this.senderId,
    required this.message,
    required this.sentAt,
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
                Row(
                  children: [
                    Text(
                      username ?? user.username,
                      style: TextStyle(
                        color: HexColor.fromHex(color ?? user.colour),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          Message.getTimestamp(sentAt),
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer
                                .withAlpha(75),
                          ),
                        ),
                      ),
                    )
                  ],
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
