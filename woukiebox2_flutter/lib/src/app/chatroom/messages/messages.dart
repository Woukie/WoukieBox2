import 'package:flutter/material.dart';
import 'package:woukiebox2/src/app/chatroom/messages/message.dart';

class Messages extends StatelessWidget {
  const Messages({
    super.key,
    required this.messages,
    this.chat = 0, // Soley for animations
  });

  final List<dynamic> messages;
  final int chat;

  static final Animatable<double> _fadeOutTransition = Tween<double>(
    begin: 1.0,
    end: 0.0,
  );

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

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
        key: Key(chat.toString()),
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
