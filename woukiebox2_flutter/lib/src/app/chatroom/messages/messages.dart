import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/app/chatroom/messages/message.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';

class Messages extends StatelessWidget {
  const Messages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final messages = Provider.of<AppStateProvider>(context).messages;

    WidgetsBinding.instance.addPostFrameCallback((duration) {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 300) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 12),
      shrinkWrap: true,
      controller: scrollController,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return Message(messages: messages, index: index);
      },
    );
  }
}
