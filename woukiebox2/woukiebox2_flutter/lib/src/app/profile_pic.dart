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
          foregroundImage: FileImage(File(url!)),
        );
      }

      return CircleAvatar(
        foregroundImage: NetworkImage(url!),
      );
    }

    return const Icon(
      Icons.account_circle,
      size: 40,
    );
  }
}
