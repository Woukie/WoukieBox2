import 'package:flutter/material.dart';
import 'package:woukiebox2/src/app/chatroom/message_box/message_box.dart';
import 'package:woukiebox2/src/app/chatroom/messages/messages.dart';
import 'package:woukiebox2/src/app/chatroom/users/users.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                const Expanded(
                  child: Card(
                    margin: EdgeInsets.all(0.0),
                    elevation: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Messages(),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  alignment: Alignment.topLeft,
                  child: const Users(),
                ),
              ],
            ),
          ),
          const MessageBox()
        ],
      ),
    );
  }
}
