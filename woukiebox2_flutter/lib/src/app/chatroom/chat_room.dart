import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/app/chatroom/message_box/message_box.dart';
import 'package:woukiebox2/src/app/chatroom/messages/messages.dart';
import 'package:woukiebox2/src/app/chatroom/users/users.dart';
import 'package:woukiebox2/src/app/direct_messages/chat_list.dart';
import 'package:woukiebox2/src/app/direct_messages/select_friend_dialogue.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({
    super.key,
    required this.global,
  });

  final bool global;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> with TickerProviderStateMixin {
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
    int? selectedGroup = appStateProvider.selectedGroup;
    List<dynamic> globalMessages = appStateProvider.messages;

    if (widget.global) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
      child: Row(
        children: [
          leftMenu(selectedGroup, appStateProvider),
          rightMenu(globalMessages, appStateProvider, selectedGroup),
        ],
      ),
    );
  }

  rightMenu(globalMessages, AppStateProvider appStateProvider, selectedGroup) =>
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Messages(
                                messages: widget.global
                                    ? globalMessages
                                    : appStateProvider
                                            .chats[selectedGroup]?.messages ??
                                        [],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                      alignment: Alignment.topLeft,
                      child: Users(
                        userIds: widget.global
                            ? List.of(appStateProvider.users.keys)
                            : appStateProvider.chats[selectedGroup]?.users ??
                                [],
                        crown: widget.global
                            ? 0
                            : appStateProvider.chats[selectedGroup]?.owner ?? 0,
                        showInvisible: !widget.global,
                      ),
                    ),
                  ],
                ),
              ),
              MessageBox(
                enabled: widget.global || selectedGroup != null,
                target: widget.global ? 0 : selectedGroup ?? 0,
              )
            ],
          ),
        ),
      );

  leftMenu(selectedGroup, appStateProvider) => SizeTransition(
        sizeFactor: _animation,
        axis: Axis.horizontal,
        axisAlignment: -1,
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: SizedBox(
            width: 200,
            child: Card(
              margin: EdgeInsets.zero,
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Filter",
                      ),
                    ),
                  ),
                  Expanded(
                    child: ChatsList(
                      selectedGroup: selectedGroup,
                      selectGroup: (value) {
                        setState(() {
                          appStateProvider.setSelectedGroup(value);
                        });
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FilledButton(
                            onPressed: () {
                              SelectFriendDialogue.showDialogue(context);
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
}
