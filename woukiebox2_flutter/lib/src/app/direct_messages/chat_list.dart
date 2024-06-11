import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/app/direct_messages/direct_message_dropdown.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/util/group_chat.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({
    super.key,
    required this.selectedGroup,
    required this.selectGroup,
    this.searchQuery = "",
  });

  final int? selectedGroup;
  final String searchQuery;
  final Function(int) selectGroup;

  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);
    final List<GroupChat> groupChats = appStateProvider.chats.values.toList();
    groupChats
        .sort((chatA, chatB) => chatB.lastMessage.compareTo(chatA.lastMessage));

    groupChats.removeWhere(
        (chat) => !chat.name.toLowerCase().contains(searchQuery.toLowerCase()));

    String generateGroupName(GroupChat groupChat) {
      List<int> members = groupChat.users
          .where((user) => user != appStateProvider.currentUser)
          .toList();

      String name = "";
      for (int i = 0; i < min(members.length, 3); i++) {
        int member = members[i];
        name += "${appStateProvider.users[member]?.username ?? "Loading"}, ";
      }

      return name.substring(0, name.length - 2);
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      itemCount: groupChats.length,
      itemBuilder: (context, index) {
        GroupChat groupChat = groupChats[index];
        bool selected = groupChat.id == selectedGroup;

        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: DirectMessageDropdown(
            groupChat: groupChat,
            child: Card(
              margin: EdgeInsets.zero,
              elevation: selected ? 1 : 0,
              color: selected
                  ? Theme.of(context).colorScheme.surfaceContainerHigh
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
                      const Icon(Icons.group),
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                      ),
                      Expanded(
                        child: Text(
                          softWrap: false,
                          groupChat.name.isEmpty
                              ? generateGroupName(groupChat)
                              : groupChat.name,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
