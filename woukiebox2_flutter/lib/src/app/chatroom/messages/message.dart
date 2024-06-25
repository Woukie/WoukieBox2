import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

import 'child_message.dart';
import 'head_message.dart';
import 'system_message.dart';

class Message extends StatelessWidget {
  const Message({super.key, required this.messages, required this.index});

  final List<NetworkChatMessage> messages;
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
        prefix = DateFormat('MMM d, yyyy').format(time.toLocal());
      }
    }

    return '$prefix at ${DateFormat('h:mm a').format(time.toLocal())}';
  }

  @override
  Widget build(BuildContext context) {
    final NetworkChatMessage message = messages[index];
    final NetworkChatMessage? parentMessage =
        index != messages.length - 1 ? messages[index + 1] : null;

    bool newDay = parentMessage != null &&
        parentMessage.sentAt?.day != message.sentAt?.day;

    Widget getRenderedWidget() {
      switch (message.action) {
        case MessageType.Message:
          bool child = parentMessage?.action == MessageType.Message &&
              parentMessage!.sender == message.sender &&
              !newDay &&
              !parentMessage.sentAt!
                  .add(const Duration(minutes: 1, seconds: 30))
                  .isBefore(message.sentAt!);

          return child
              ? ChildMessage(chatMessage: message)
              : HeadMessage(chatMessage: message);
        case MessageType.AddFriends:
          return SystemMessage(
            senderId: message.sender,
            actionText: " added ",
            targetIds: message.targets,
          );
        case MessageType.Rename:
          return SystemMessage(
            senderId: message.sender,
            actionText: " renamed the chat to '${message.message}'",
          );
        case MessageType.Create:
          return SystemMessage(
            senderId: message.sender,
            actionText: " created the chat",
          );
        case MessageType.Kick:
          return SystemMessage(
            senderId: message.sender,
            actionText: " kicked ",
            targetIds: message.targets,
          );
        case MessageType.Leave:
          return SystemMessage(
            senderId: message.sender,
            actionText: " left the chat",
          );
        case MessageType.Promote:
          return SystemMessage(
            senderId: message.sender,
            actionText: " promoted ",
            targetIds: message.targets,
          );
        default:
          return const Text("unknown chat message :)");
      }
    }

    return Column(
      children: [
        newDay
            ? Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Divider(),
                    ),
                  ),
                  Text(DateFormat('MMMM d, y').format(message.sentAt!)),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Divider(),
                    ),
                  ),
                ],
              )
            : Container(),
        getRenderedWidget(),
      ],
    );
  }
}
