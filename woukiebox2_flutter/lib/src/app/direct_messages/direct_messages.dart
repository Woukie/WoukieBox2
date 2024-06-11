import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/app/chatroom/message_box/message_box.dart';
import 'package:woukiebox2/src/app/chatroom/messages/messages.dart';
import 'package:woukiebox2/src/app/chatroom/users/users.dart';
import 'package:woukiebox2/src/app/direct_messages/chat_list.dart';
import 'package:woukiebox2/src/app/direct_messages/select_friend_dialogue.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';

class DirectMessages extends StatefulWidget {
  const DirectMessages({
    super.key,
  });

  @override
  State<DirectMessages> createState() => _DirectMessagesState();
}

class _DirectMessagesState extends State<DirectMessages> {
  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);
    int? selectedGroup = appStateProvider.selectedGroup;

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
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerLow,
                            margin: EdgeInsets.zero,
                            elevation: 1,
                            child: selectedGroup == null
                                ? Container()
                                : Messages(
                                    messages: appStateProvider
                                        .chats[selectedGroup]!.messages,
                                  ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Users(
                            userIds:
                                appStateProvider.chats[selectedGroup]?.users ??
                                    [],
                            crown:
                                appStateProvider.chats[selectedGroup]?.owner ??
                                    0,
                            showInvisible: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MessageBox(
                      enabled: selectedGroup != null,
                      target: selectedGroup ?? 0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
