import 'package:flutter/material.dart';
import 'package:woukiebox2/src/app/chatroom/messages/system_message_wrapper.dart';
import 'package:woukiebox2/src/util/hex_color.dart';
import 'package:woukiebox2/src/util/user.dart';

class SystemMessage extends StatelessWidget {
  final int senderId;
  final String actionText;
  final List<int>? targetIds;

  const SystemMessage({
    super.key,
    required this.senderId,
    required this.actionText,
    this.targetIds,
  });

  @override
  Widget build(BuildContext context) {
    User sender = User.getUser(context, senderId);

    List<InlineSpan>? children = [
      TextSpan(
        text: sender.username,
        style: TextStyle(
          color: HexColor.fromHex(sender.colour),
        ),
      ),
      TextSpan(
        text: actionText,
      ),
    ];

    if (targetIds != null) {
      int targetCount = targetIds!.length;
      for (var i = 0; i < targetCount; i++) {
        User target = User.getUser(context, targetIds![i]);

        children.add(
          TextSpan(
            text: target.username,
            style: TextStyle(
              color: target.getColor(),
            ),
          ),
        );

        if (i < targetCount) {
          children.add(
            TextSpan(
              text: i < targetCount - 1 ? ", " : " and ",
            ),
          );
        }
      }
    }

    return SystemMessageWrapper(
      child: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: children,
      ),
    );
  }
}
