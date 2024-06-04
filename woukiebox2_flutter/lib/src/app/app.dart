import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/app/main_app_bar.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:woukiebox2/main.dart';
import 'package:woukiebox2/src/app/profile_pic.dart';
import 'package:woukiebox2/src/providers/connection_state_provider.dart';
import 'package:woukiebox2/src/util/hex_color.dart';

import 'message.dart';
import 'profile_preview.dart';

void sendMessage(String message) {
  client.sockets.sendStreamMessage(ChatMessage(message: message));
}

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final connectionProvider =
          Provider.of<ConnectionStateProvider>(context, listen: false);
      if (connectionProvider.connectionHandler.status.status ==
          StreamingConnectionStatus.disconnected) {
        connectionProvider.openConnection();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: Border.all(width: 0, color: Colors.transparent),
      margin: const EdgeInsets.all(0),
      child: Column(
        children: [
          const MainAppBar(),
          Expanded(
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
            ),
          ),
        ],
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
    final connectionStateProvider =
        Provider.of<ConnectionStateProvider>(context);
    final users = connectionStateProvider.users;
    final List<User> userList = users.values.toList();
    final User localUser = users[connectionStateProvider.currentUser]!;
    userList
        .removeWhere((user) => !(user.visible ?? true) || user == localUser);

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ProfilePreview(
              // chatbox only renders in there is a user thus the user is not null
              user: localUser,
              child: Card(
                margin: EdgeInsets.zero,
                child: UserItem(
                  colour: HexColor.fromHex(localUser.colour),
                  image: localUser.image,
                  username: localUser.username,
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        Color color = HexColor.fromHex(userList[index].colour);
                        User user = userList[index];

                        return ProfilePreview(
                          user: user,
                          child: UserItem(
                            colour: color,
                            image: user.image,
                            username: user.username,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserItem extends StatefulWidget {
  const UserItem({
    super.key,
    required this.username,
    required this.colour,
    required this.image,
  });

  final String username;
  final String image;
  final Color colour;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProfilePic(
            url: widget.image,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              softWrap: false,
              overflow: TextOverflow.fade,
              maxLines: 1,
              widget.username,
              style: TextStyle(
                color: widget.colour,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
