import 'package:flutter/material.dart';
import 'package:woukiebox2/src/app/profile/profile_more_dropdown.dart';
import 'package:woukiebox2/src/app/profile/profile_pic.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.username,
    required this.colour,
    required this.image,
    required this.userId,
    this.crowned = false,
    this.disabled = false,
  });

  final String username;
  final String image;
  final Color colour;
  final int userId;
  final bool crowned;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return ProfileMoreDropdown(
      userId: userId,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProfilePic(
              offline: disabled,
              url: image,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                softWrap: false,
                overflow: TextOverflow.fade,
                maxLines: 1,
                username,
                style: TextStyle(
                  color: Color.lerp(colour, Colors.grey, disabled ? 0.7 : 0)
                      ?.withAlpha(disabled ? 90 : 255),
                ),
              ),
            ),
          ),
          crowned
              ? Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.shield,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant
                        .withAlpha(disabled ? 90 : 255),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
