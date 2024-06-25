import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/app/direct_messages/direct_message_dropdown.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/util/group_chat.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({
    super.key,
    this.searchQuery = "",
  });

  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);

    final List<GroupChat> groupChats = appStateProvider.chats.values.toList();
    groupChats.sort(
      (chatA, chatB) {
        bool unreadA = chatA.hasNotifications(context);
        if (unreadA != chatB.hasNotifications(context)) return unreadA ? -1 : 1;

        return chatB.lastMessage.compareTo(chatA.lastMessage);
      },
    );

    groupChats.removeWhere((chat) {
      if (chat.name.isEmpty) {
        return !chat
            .getName(context)
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
        bool selected = groupChat.id == appStateProvider.selectedChat;

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
                  appStateProvider.setSelectedGroup(groupChat.id);
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
                          groupChat.getName(context),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      groupChat.hasNotifications(context)
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
