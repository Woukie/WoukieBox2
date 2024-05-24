import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:woukiebox2_flutter/main.dart';
import 'package:woukiebox2_flutter/src/providers/connection_state_provider.dart';
import 'package:woukiebox2_flutter/src/util/hex_color.dart';

import 'message.dart';

void sendMessage(String message) {
  client.sockets.sendStreamMessage(ChatMessage(message: message));
}

class ChatBox extends StatefulWidget {
  const ChatBox({
    super.key,
  });

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final connectionProvider =
          Provider.of<ConnectionStateProvider>(context, listen: false);
      if (connectionProvider.state == ConnectionState.none) {
        connectionProvider.openConnection();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
                  Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(left: 12),
                    child: Container(
                      width: 200,
                      alignment: Alignment.topLeft,
                      child: const Users(),
                    ),
                  ),
                ],
              ),
            ),
            const MessageBox()
          ],
        ),
      ),
    );
  }
}

class MessageBox extends StatefulWidget {
  const MessageBox({
    super.key,
  });

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  final _controller = TextEditingController();

  late final _focusNode = FocusNode(
    onKeyEvent: (FocusNode node, KeyEvent event) {
      if (event is KeyDownEvent &&
          event.logicalKey.keyLabel == "Enter" &&
          !HardwareKeyboard.instance.isShiftPressed) {
        sendMessage(_controller.text);
        _controller.clear();
        return KeyEventResult.handled;
      }

      return KeyEventResult.ignored;
    },
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(top: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: TextField(
          controller: _controller,
          maxLines: null,
          decoration: const InputDecoration(
            isDense: true,
            border: InputBorder.none,
            hintText: "Send Message...",
          ),
          onSubmitted: (value) {
            sendMessage(_controller.text);
            _controller.clear();
          },
          focusNode: _focusNode,
        ),
      ),
    );
  }
}

class Messages extends StatelessWidget {
  const Messages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final messages = Provider.of<ConnectionStateProvider>(context).messages;

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

class Users extends StatelessWidget {
  const Users({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<ConnectionStateProvider>(context).users;
    final List<User> userList = users.values.toList();
    userList.removeWhere((user) => !(user.visible ?? true));

    return ListView.builder(
      itemCount: userList.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  userList[index].username,
                  style: TextStyle(
                    color: HexColor.fromHex(userList[index].colour),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
