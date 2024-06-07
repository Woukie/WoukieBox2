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
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);

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
            appStateProvider.friends,
            appStateProvider.outgoingFriendRequests,
            appStateProvider.incomingFriendRequests,
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
      List<int> incomingFriendRequests) {
    return [
      PopupMenuItem(
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.person_add),
            ),
            Text(
              friends.contains(userId)
                  ? "Remove Friend"
                  : outgoingFriendRequests.contains(userId)
                      ? "Cancel Friend Request"
                      : incomingFriendRequests.contains(userId)
                          ? "Reject Friend Request"
                          : "Send Friend Request",
            ),
          ],
        ),
      ),
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
    ];
  }
}
