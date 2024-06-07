import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';

class ProfileMoreDropdown extends StatelessWidget {
  const ProfileMoreDropdown(
      {super.key, required this.child, required this.userId});

  final Widget child;
  final int userId;

  // Wraps an element in an InkWell that opens the more dropdown on secondarry input
  @override
  Widget build(BuildContext context) {
    AppStateProvider appData = Provider.of<AppStateProvider>(context);

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
          items: getDropdownElements(
            context,
            userId,
            appData.friends,
            appData.outgoingFriendRequests,
            appData.incomingFriendRequests,
            appData.currentUser == userId ||
                !appData.users[appData.currentUser]!.verified,
          ),
        );
      },
    );
  }

  static List<PopupMenuItem> getDropdownElements(
    BuildContext context,
    int userId,
    List<int> friends,
    List<int> outgoingFriendRequests,
    List<int> incomingFriendRequests,
    bool showFriendButtons,
  ) {
    bool friendly = friends.contains(userId);
    bool outgoing = outgoingFriendRequests.contains(userId);
    bool incoming = incomingFriendRequests.contains(userId);

    List<PopupMenuItem> items = List.empty(growable: true);

    if (!showFriendButtons) {
      if (friendly) {
        items.add(getButton("Remove Friend", Icons.person_remove, null));
      } else if (outgoing) {
        items.add(getButton("Cancel Friend Request", Icons.close, null));
      } else if (incoming) {
        items.add(getButton("Accept Friend Request", Icons.person_add, null));
        items.add(getButton("Send Friend Request", Icons.person_add, null));
      } else {
        items.add(getButton("Send Friend Request", Icons.outgoing_mail, null));
      }
    }

    items.add(
      const PopupMenuItem(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.hardware),
            ),
            Text('Kill'),
          ],
        ),
      ),
    );

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
