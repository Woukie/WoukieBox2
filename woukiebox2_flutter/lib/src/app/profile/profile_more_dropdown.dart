import 'package:flutter/material.dart';

class ProfileMoreDropdown extends StatelessWidget {
  const ProfileMoreDropdown(
      {super.key, required this.child, required this.userId});

  final Widget child;
  final int userId;

  // Wraps an element in an InkWell that opens the more dropdown on secondarry input
  @override
  Widget build(BuildContext context) {
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
          items: getDropdownElements(userId),
        );
      },
    );
  }

  static getDropdownElements(int userId) {
    return [
      const PopupMenuItem(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.person_add),
            ),
            Text('Add Friend'),
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
