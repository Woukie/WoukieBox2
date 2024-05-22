import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

class Message extends StatelessWidget {
  const Message({super.key, required this.messages, required this.index});

  final List<ChatMessage> messages;
  final int index;

  @override
  Widget build(BuildContext context) {
    final bool head =
        index == 0 || messages[index - 1].sender != messages[index].sender;

    return head
        ? HeadMessage(message: messages[index])
        : ChildMessage(message: messages[index]);
  }
}

class HeadMessage extends StatelessWidget {
  const HeadMessage({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: CircleAvatar(
              radius: 20,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${message.sender}"),
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

  final ChatMessage message;

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
