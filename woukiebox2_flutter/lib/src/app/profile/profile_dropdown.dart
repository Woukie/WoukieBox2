import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/main.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/util/group_chat.dart';
import 'package:woukiebox2/src/util/user.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

class ProfileDropdown {
  static List<PopupMenuEntry<dynamic>> _getDropdownElements(
      AppStateProvider appStateProvider, int userId) {
    bool friendly = appStateProvider.friends.contains(userId);
    bool outgoing = appStateProvider.outgoingFriendRequests.contains(userId);
    bool incoming = appStateProvider.incomingFriendRequests.contains(userId);

    GroupChat? chat = appStateProvider.isChatSelected()
        ? appStateProvider.chats[appStateProvider.selectedChat]
        : null;

    bool admin = chat != null &&
        chat.owners.contains(appStateProvider.currentUser) &&
        userId != appStateProvider.currentUser &&
        !chat.owners.contains(userId);

    User currentUser = appStateProvider.users[appStateProvider.currentUser]!;
    User? targetUser = appStateProvider.users[userId];

    if (targetUser == null) return [];

    bool showFriendButtons =
        currentUser.id != userId && currentUser.verified && targetUser.verified;

    List<PopupMenuItem> items = List.empty(growable: true);

    getButton(String text, IconData iconData, void Function()? callback) {
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
          NetworkChatMessage(
            action: MessageType.Kick,
            targets: [userId],
            chat: chat.id,
          ),
        );
      }));

      items.add(getButton("Promote", Icons.shield, () {
        client.sockets.sendStreamMessage(
          NetworkChatMessage(
            action: MessageType.Promote,
            targets: [userId],
            chat: chat.id,
          ),
        );
      }));
    }

    return items;
  }

  // Returns a button that opens the dropdown when pressed
  static Widget moreButton(
    BuildContext context,
    AppStateProvider appStateProvider,
    int userId,
  ) {
    return PopupMenuButton(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      tooltip: "More",
      itemBuilder: (BuildContext _) {
        return _getDropdownElements(appStateProvider, userId);
      },
      icon: const Icon(Icons.more_horiz),
    );
  }

  // Wraps an element in an InkWell that opens the dropdown on secondary input
  static Widget rightClickWrapper(
    BuildContext context,
    int userId,
    Widget child,
  ) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onSecondaryTapDown: (details) async {
        final screenSize = MediaQuery.of(context).size;
        Offset offset = details.globalPosition;

        await showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            offset.dx,
            offset.dy,
            screenSize.width - offset.dx,
            screenSize.height - offset.dy,
          ),
          items: _getDropdownElements(appStateProvider, userId),
        );
      },
      child: child,
    );
  }
}
