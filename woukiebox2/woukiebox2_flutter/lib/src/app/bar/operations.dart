import 'package:flutter/material.dart';
import 'package:woukiebox2_flutter/main.dart';
import 'package:woukiebox2_flutter/src/app/settings_page.dart';

import '../profile_page.dart';

class Operations extends StatelessWidget {
  const Operations({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
            ),
            padding: EdgeInsets.zero,
            tooltip: 'Profile',
            onPressed: () {
              showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return const ProfilePage();
                },
              );
            },
          ),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: IconButton(
            icon: const Icon(
              Icons.settings,
            ),
            padding: EdgeInsets.zero,
            tooltip: 'Settings',
            onPressed: () {
              showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return const SettingsPage();
                },
              );
            },
          ),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: IconButton(
            icon: const Icon(
              Icons.logout,
            ),
            padding: EdgeInsets.zero,
            tooltip: 'Log Out',
            color: Theme.of(context).colorScheme.error,
            onPressed: () {
              sessionManager.signOut();
            },
          ),
        ),
      ],
    );
  }
}
