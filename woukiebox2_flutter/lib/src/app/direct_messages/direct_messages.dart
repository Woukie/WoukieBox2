import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/main.dart';
import 'package:woukiebox2/src/app/chatroom/message_box/message_box.dart';
import 'package:woukiebox2/src/app/chatroom/messages/messages.dart';
import 'package:woukiebox2/src/app/profile/profile_pic.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/util/group_chat.dart';
import 'package:woukiebox2/src/util/hex_color.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

class DirectMessages extends StatefulWidget {
  const DirectMessages({
    super.key,
  });

  @override
  State<DirectMessages> createState() => _DirectMessagesState();
}

class _DirectMessagesState extends State<DirectMessages> {
  int? _selectedGroup;

  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);

    final List<GroupChat> groupChats = appStateProvider.chats.values.toList();

    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        child: Row(
          children: [
            Card(
              margin: const EdgeInsets.only(right: 12),
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              child: SizedBox(
                width: 200,
                child: Stack(
                  children: [
                    ChatsList(
                      selectedGroup: _selectedGroup,
                      selectGroup: (selectedGroup) {
                        setState(() {
                          _selectedGroup = selectedGroup;
                        });
                      },
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: FloatingActionButton.small(
                          onPressed: () {
                            _createFriendSelectionDialog(context);
                          },
                          child: const Icon(Icons.add),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Card(
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
                      margin: EdgeInsets.zero,
                      elevation: 1,
                      child: _selectedGroup == null
                          ? Container()
                          : Messages(
                              messages: groupChats[_selectedGroup!].messages,
                            ),
                    ),
                  ),
                  MessageBox(target: _selectedGroup ?? 0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createFriendSelectionDialog(BuildContext context) {
    HashMap<int, bool> friendsSelection = HashMap<int, bool>();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        AppStateProvider appStateProvider =
            Provider.of<AppStateProvider>(context);

        List<int> friends = appStateProvider.friends;

        HashMap<int, bool> updatedSelection = HashMap<int, bool>();
        for (var friend in friends) {
          updatedSelection[friend] = friendsSelection[friend] ?? false;
        }
        friendsSelection = updatedSelection;

        return StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Select Contacts"),
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                            itemCount: friends.length,
                            itemBuilder: (BuildContext context, int index) {
                              int friendId = friends[index];

                              UserClient? user =
                                  appStateProvider.users[friendId];

                              if (user == null) {
                                appStateProvider.scheduleGetUser(friendId);
                              }

                              return InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  setState(() {
                                    friendsSelection[friendId] =
                                        !friendsSelection[friendId]!;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      ProfilePic(
                                        url: user == null ? "" : user.image,
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(right: 8)),
                                      Expanded(
                                        child: Text(
                                          style: TextStyle(
                                            color: user == null
                                                ? null
                                                : HexColor.fromHex(user.colour),
                                          ),
                                          user == null
                                              ? "Loading..."
                                              : user.username,
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(right: 8)),
                                      Checkbox(
                                        value: friendsSelection[friendId],
                                        onChanged: (value) {
                                          if (value == null) return;
                                          setState(() {
                                            friendsSelection[friendId] = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(right: 8)),
                            FilledButton(
                              onPressed: () {
                                friendsSelection
                                    .removeWhere((user, selected) => !selected);
                                client.sockets.sendStreamMessage(
                                  CreateChatClient(
                                    users: List.of(friendsSelection.keys),
                                  ),
                                );

                                Navigator.of(context).pop();
                              },
                              child: const Text('Create'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChatsList extends StatelessWidget {
  const ChatsList({
    super.key,
    required this.selectedGroup,
    required this.selectGroup,
  });

  final int? selectedGroup;
  final Function(int) selectGroup;

  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);
    final List<GroupChat> groupChats = appStateProvider.chats.values.toList();

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      itemCount: groupChats.length,
      itemBuilder: (context, index) {
        GroupChat groupChat = groupChats[index];
        bool selected = groupChat.id == selectedGroup;

        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Card(
            margin: EdgeInsets.zero,
            elevation: selected ? 1 : 0,
            color: selected
                ? Theme.of(context).colorScheme.surfaceContainer
                : null,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                selectGroup(groupChat.id);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Row(
                  children: [
                    const ProfilePic(url: ""),
                    const Padding(
                      padding: EdgeInsets.only(right: 12),
                    ),
                    Expanded(
                      child: Text(
                        softWrap: false,
                        groupChat.name,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
