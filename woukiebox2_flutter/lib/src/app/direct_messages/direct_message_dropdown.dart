import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/main.dart';
import 'package:woukiebox2/src/app/direct_messages/rename_chat_dialogue.dart';
import 'package:woukiebox2/src/app/direct_messages/select_friend_dialogue.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/util/group_chat.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

class DirectMessageDropdown extends StatelessWidget {
  const DirectMessageDropdown({
    super.key,
    required this.child,
    required this.groupChat,
    this.enabled = true,
  });

  final GroupChat groupChat;
  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return enabled
        ? StatefulBuilder(
            builder: (context, setState) {
              AppStateProvider appStateProvider =
                  Provider.of<AppStateProvider>(context);

              return InkWell(
                borderRadius: BorderRadius.circular(12),
                child: child,
                onSecondaryTapDown: (details) {
                  final screenSize = MediaQuery.of(context).size;
                  Offset offset = details.globalPosition;

                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                      offset.dx,
                      offset.dy,
                      screenSize.width - offset.dx,
                      screenSize.height - offset.dy,
                    ),
                    items: _getDropdownElements(
                      groupChat,
                      context,
                      groupChat.owners.contains(appStateProvider.currentUser),
                    ),
                  );
                },
              );
            },
          )
        : Container(child: child);
  }

  List<PopupMenuItem> _getDropdownElements(
    GroupChat groupChat,
    BuildContext context,
    bool owner,
  ) {
    List<PopupMenuItem> items = List.empty(growable: true);

    if (owner) {
      items.add(getButton("Rename", Icons.edit, () {
        RenameChatDialogue.showDialogue(context, groupChat.id);
      }));
      items.add(getButton("Add Users", Icons.person_add, () {
        SelectFriendDialogue.showDialogue(
          context,
          (List<int> selectedFriends) {
            client.sockets.sendStreamMessage(
              AddChatMembersClient(
                users: selectedFriends,
                chat: groupChat.id,
              ),
            );
          },
          groupChat.id,
        );
      }));
    }

    items.add(getButton("Leave", Icons.exit_to_app, () {
      client.sockets.sendStreamMessage(LeaveChatClient(chat: groupChat.id));
    }));

    return items;
  }

  static getButton(String text, IconData iconData, void Function()? callback) {
    return PopupMenuItem(
      onTap: callback,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(iconData),
          ),
          Text(text),
        ],
      ),
    );
  }
}
