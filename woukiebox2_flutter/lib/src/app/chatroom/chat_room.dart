import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/app/chatroom/message_box/message_box.dart';
import 'package:woukiebox2/src/app/chatroom/messages/messages.dart';
import 'package:woukiebox2/src/app/chatroom/users/users.dart';
import 'package:woukiebox2/src/app/direct_messages/chat_list.dart';
import 'package:woukiebox2/src/app/direct_messages/select_friend_dialogue.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/providers/styling_provider.dart';

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
    int? selectedGroup = appStateProvider.selectedGroup;
    List<dynamic> globalMessages = appStateProvider.messages;

    if (widget.global) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        stylingProvider.cardMargin,
        stylingProvider.cardMargin,
        stylingProvider.cardMargin,
      ),
      child: Row(
        children: [
          leftMenu(selectedGroup, appStateProvider, stylingProvider),
          rightMenu(
              globalMessages, appStateProvider, selectedGroup, stylingProvider),
        ],
      ),
    );
  }

  rightMenu(
    globalMessages,
    AppStateProvider appStateProvider,
    int? selectedGroup,
    StylingProvider stylingProvider,
  ) =>
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: stylingProvider.cardMargin),
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
                                chat: widget.global ? 0 : selectedGroup ?? -1,
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
                        showInvisible: !widget.global,
                        owners: widget.global
                            ? []
                            : appStateProvider.chats[selectedGroup]?.owners ??
                                [],
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

  leftMenu(
    selectedGroup,
    AppStateProvider appStateProvider,
    StylingProvider stylingProvider,
  ) =>
      SizeTransition(
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
                      selectedGroup: selectedGroup,
                      selectGroup: (value) {
                        setState(() {
                          appStateProvider.readChat(value);
                          appStateProvider.setSelectedGroup(value);
                        });
                      },
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
