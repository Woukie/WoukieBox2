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

    bool chatUnread(GroupChat chat) {
      return appStateProvider.selectedGroup != chat.id &&
          (!appStateProvider.lastRead.containsKey(chat.id) ||
              chat.lastMessage.isAfter(appStateProvider.lastRead[chat.id]!));
    }

    final List<GroupChat> groupChats = appStateProvider.chats.values.toList();
    groupChats.sort(
      (chatA, chatB) {
        bool unreadA = chatUnread(chatA);
        if (unreadA != chatUnread(chatB)) return unreadA ? -1 : 1;

        return chatB.lastMessage.compareTo(chatA.lastMessage);
      },
    );

    groupChats.removeWhere((chat) {
      if (chat.name.isEmpty) {
        return !GroupChat.generateGroupName(chat, appStateProvider)
            .toLowerCase()
            .contains(searchQuery.toLowerCase());
      }
      return !chat.name.toLowerCase().contains(searchQuery.toLowerCase());
    });

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      itemCount: groupChats.length,
      itemBuilder: (context, index) {
        GroupChat groupChat = groupChats[index];
        bool selected = groupChat.id == selectedGroup;

        bool unread = chatUnread(groupChat);

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
                      groupChat.users.length <= 2
                          ? Icon(
                              Icons.person,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            )
                          : Icon(
                              Icons.group,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                      ),
                      Expanded(
                        child: Text(
                          softWrap: false,
                          groupChat.name.isEmpty
                              ? GroupChat.generateGroupName(
                                  groupChat, appStateProvider)
                              : groupChat.name,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      unread
                          ? Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            )
                          : Container(),
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
