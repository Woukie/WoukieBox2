import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/app/chatroom/messages/message.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

class Messages extends StatelessWidget {
  const Messages({
    super.key,
  });

  static final Animatable<double> _fadeOutTransition = Tween<double>(
    begin: 1.0,
    end: 0.0,
  );

  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);
    final scrollController = ScrollController();

    final int? chat = appStateProvider.isGlobalChatSelected()
        ? 0
        : appStateProvider.selectedChat;
    final List<NetworkChatMessage> messages =
        appStateProvider.isGlobalChatSelected()
            ? appStateProvider.globalMessages
            : appStateProvider.chats[chat]?.messages ?? [];

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (scrollController.position.maxScrollExtent <= 200) {
        appStateProvider.loadNextBucket(chat);
      }
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        appStateProvider.loadNextBucket(chat);
      }
    });

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      transitionBuilder: (child, animation) {
        return DualTransitionBuilder(
          animation: animation,
          forwardBuilder: (
            BuildContext context,
            Animation<double> animation,
            Widget? child,
          ) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(0.1, 0),
                end: const Offset(0, 0),
              ).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          reverseBuilder: (
            BuildContext context,
            Animation<double> animation,
            Widget? child,
          ) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(0, 0),
                end: const Offset(0.1, 0),
              ).animate(animation),
              child: FadeTransition(
                opacity: _fadeOutTransition.animate(animation),
                child: child,
              ),
            );
          },
          child: child,
        );
      },
      child: ListView.builder(
        key: Key((appStateProvider.isGlobalChatSelected()
                ? 0
                : appStateProvider.selectedChat)
            .toString()),
        padding: const EdgeInsets.only(bottom: 12),
        controller: scrollController,
        itemCount: messages.length,
        reverse: true,
        itemBuilder: (context, index) {
          return Message(messages: List.from(messages.reversed), index: index);
        },
      ),
    );
  }
}
