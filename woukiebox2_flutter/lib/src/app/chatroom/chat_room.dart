import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/app/chatroom/message_box/message_box.dart';
import 'package:woukiebox2/src/app/chatroom/messages/messages.dart';
import 'package:woukiebox2/src/app/chatroom/users/users.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<dynamic> messages = Provider.of<AppStateProvider>(context).messages;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    margin: const EdgeInsets.all(0.0),
                    elevation: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Messages(messages: messages),
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
