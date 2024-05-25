import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        Color color = HexColor.fromHex(userList[index].colour);
        User user = userList[index];

        return GestureDetector(
          onTapDown: (TapDownDetails details) async {
            final screenSize = MediaQuery.of(context).size;
            Offset offset = details.globalPosition;

            await showMenu(
              context: context,
              position: RelativeRect.fromLTRB(
                offset.dx,
                offset.dy,
                screenSize.width - offset.dx,
                screenSize.height - offset.dy,
              ),
              items: [
                PopupMenuItem(
                  enabled: false,
                  child: ProfilePreview(user: user),
                ),
              ],
              elevation: 8.0,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              margin: EdgeInsets.zero,
              child: UserItem(
                colour: color,
                username: user.username,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProfilePreview extends StatelessWidget {
  const ProfilePreview({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).primaryTextTheme.bodyMedium!;

    return SizedBox(
      width: 200,
      height: 250,
      child: Padding(
        // Unify the padding from the stock popup
        padding: const EdgeInsets.only(top: 3, bottom: 3),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      style: textStyle.copyWith(
                        color: HexColor.fromHex(user.colour),
                      ),
                      user.username,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 4,
                              bottom: 4,
                            ),
                            child: Text(
                              user.bio == ""
                                  ? "This user has no bio..."
                                  : user.bio,
                              style: user.bio == ""
                                  ? const TextStyle(fontStyle: FontStyle.italic)
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.username,
    required this.colour,
  });

  final String username;
  final Color colour;

  @override
  Widget build(BuildContext context) {
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
              username,
              style: TextStyle(
                color: colour,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
