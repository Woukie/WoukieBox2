import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/main.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/util/group_chat.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

class ProfileMoreDropdown extends StatelessWidget {
  const ProfileMoreDropdown({
    super.key,
    required this.child,
    required this.userId,
    this.enabled = true,
  });

  final Widget child;
  final int userId;
  final bool enabled;

  // Wraps an element in an InkWell that opens the more dropdown on secondarry input
  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);

    return enabled
        ? InkWell(
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
                items: getDropdownElements(
                  appStateProvider,
                  userId,
                ),
              );
            },
          )
        : Container(child: child);
  }

  static List<PopupMenuItem> getDropdownElements(
    AppStateProvider appStateProvider,
    int userId,
  ) {
    bool friendly = appStateProvider.friends.contains(userId);
    bool outgoing = appStateProvider.outgoingFriendRequests.contains(userId);
    bool incoming = appStateProvider.incomingFriendRequests.contains(userId);

    GroupChat? chat = !appStateProvider.isGlobal()
        ? appStateProvider.chats[appStateProvider.selectedChat]
        : null;

    bool admin = chat != null &&
        chat.owners.contains(appStateProvider.currentUser) &&
        userId != appStateProvider.currentUser &&
        !chat.owners.contains(userId);

    UserClient currentUser =
        appStateProvider.users[appStateProvider.currentUser]!;
    UserClient? targetUser = appStateProvider.users[userId];

    if (targetUser == null) return [];

    bool showFriendButtons =
        currentUser.id != userId && currentUser.verified && targetUser.verified;

    List<PopupMenuItem> items = List.empty(growable: true);

    friend(bool positive) {
      client.sockets.sendStreamMessage(
        FriendRequestClient(
          target: userId,
          positive: positive,
        ),
      );
    }

    if (showFriendButtons) {
      if (friendly) {
        items.add(getButton(
            "Remove Friend", Icons.person_remove, () => friend(false)));
      } else if (outgoing) {
        items.add(getButton(
            "Cancel Friend Request", Icons.close, () => friend(false)));
      } else if (incoming) {
        items.add(getButton(
            "Accept Friend Request", Icons.person_add, () => friend(true)));
        items.add(getButton(
            "Reject Friend Request", Icons.person_off, () => friend(false)));
      } else {
        items.add(getButton(
            "Send Friend Request", Icons.outgoing_mail, () => friend(true)));
      }
    }

    if (admin) {
      items.add(getButton("Kick", Icons.hardware, () {
        client.sockets.sendStreamMessage(
          KickChatMemberClient(user: userId, chat: chat.id),
        );
      }));
      items.add(getButton("Promote", Icons.hardware, () {
        client.sockets.sendStreamMessage(
          PromoteChatMemberClient(user: userId, chat: chat.id),
        );
      }));
    }

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
