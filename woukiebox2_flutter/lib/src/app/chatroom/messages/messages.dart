import 'package:flutter/material.dart';
import 'package:woukiebox2/src/app/chatroom/messages/message.dart';

class Messages extends StatelessWidget {
  const Messages({
    super.key,
    required this.messages,
  });

  final List<dynamic> messages;

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 12),
      controller: scrollController,
      itemCount: messages.length,
      reverse: true,
      itemBuilder: (context, index) {
        return Message(messages: List.from(messages.reversed), index: index);
      },
    );
  }
}
