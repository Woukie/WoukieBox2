import 'package:flutter/material.dart';
import 'package:woukiebox2/src/app/profile/profile_pic.dart';

class UserItem extends StatefulWidget {
  const UserItem({
    super.key,
    required this.username,
    required this.colour,
    required this.image,
  });

  final String username;
  final String image;
  final Color colour;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProfilePic(
            url: widget.image,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              softWrap: false,
              overflow: TextOverflow.fade,
              maxLines: 1,
              widget.username,
              style: TextStyle(
                color: widget.colour,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
