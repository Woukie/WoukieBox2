import 'dart:io';

import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final String? url;
  final bool? local;

  const ProfilePic({super.key, this.url, this.local});

  @override
  Widget build(BuildContext context) {
    if (url != null && url != "") {
      if (local != null && local!) {
        return CircleAvatar(
          radius: 20,
          foregroundImage: FileImage(File(url!)),
        );
      }

      return CircleAvatar(
        radius: 20,
        foregroundImage: NetworkImage(url!),
      );
    }

    return const Icon(
      size: 40,
      Icons.person,
    );
  }
}
