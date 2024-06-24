import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/main.dart';
import 'package:woukiebox2/src/app/chatroom/message_box/message_box.dart';
import 'package:woukiebox2/src/app/chatroom/messages/messages.dart';
import 'package:woukiebox2/src/app/chatroom/users/users.dart';
import 'package:woukiebox2/src/app/direct_messages/chat_list.dart';
import 'package:woukiebox2/src/app/direct_messages/select_friend_dialogue.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/providers/styling_provider.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);
    StylingProvider stylingProvider = Provider.of<StylingProvider>(context);
    bool global = appStateProvider.isGlobal();

    if (global) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    rightScreen() => Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: stylingProvider.cardMargin),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Expanded(
                        child: Card(
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(child: Messages()),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        alignment: Alignment.topLeft,
                        child: Users(
                          showInvisible: !global,
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

    friendsList() => SizeTransition(
          sizeFactor: _animation,
          axis: Axis.horizontal,
          axisAlignment: -1,
          child: Padding(
            padding: EdgeInsets.only(left: stylingProvider.cardMargin),
            child: SizedBox(
              width: 200,
              child: Card(
                margin: EdgeInsets.zero,
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          labelText: "Filter",
                        ),
                        onChanged: (value) => setState(() {}),
                      ),
                    ),
                    Expanded(
                      child: ChatsList(
                        searchQuery: _searchController.text,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: FilledButton(
                              onPressed: () {
                                SelectFriendDialogue.showDialogue(
                                  context,
                                  (List<int> friendsSelection) {
                                    client.sockets.sendStreamMessage(
                                      CreateChatClient(
                                        name: "",
                                        owners: [],
                                        users: friendsSelection,
                                      ),
                                    );
                                  },
                                  "Create Chat",
                                  "Create",
                                  null,
                                );
                              },
                              child: const Text("Create Group"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        stylingProvider.cardMargin,
        stylingProvider.cardMargin,
        stylingProvider.cardMargin,
      ),
      child: Row(
        children: [
          friendsList(),
          rightScreen(),
        ],
      ),
    );
  }
}
