import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

class ChildMessage extends StatefulWidget {
  final NetworkChatMessage chatMessage;

  const ChildMessage({
    super.key,
    required this.chatMessage,
  });

  @override
  State<ChildMessage> createState() => _ChildMessageState();
}

class _ChildMessageState extends State<ChildMessage> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) => setState(() {
        hovering = true;
      }),
      onExit: (value) => setState(() {
        hovering = false;
      }),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: SizedBox(
              width: 40,
              child: Text(
                !hovering
                    ? ""
                    : DateFormat('HH:mm').format(
                        widget.chatMessage.sentAt!.toLocal(),
                      ),
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimaryContainer
                      .withAlpha(75),
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              widget.chatMessage.message!,
            ),
          ),
        ],
      ),
    );
  }
}
