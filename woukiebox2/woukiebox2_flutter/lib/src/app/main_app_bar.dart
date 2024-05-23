import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2_flutter/main.dart';
import 'package:woukiebox2_flutter/src/app/profile_page.dart';
import 'package:woukiebox2_flutter/src/app/settings_page.dart';
import 'package:woukiebox2_flutter/src/providers/connection_state_provider.dart';
import 'package:woukiebox2_flutter/src/providers/joined_anonymously_provider.dart';

import '../app_bar_buttons.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: Border.all(color: Colors.transparent, width: 0),
      child: WindowTitleBarBox(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            children: [
              const LeftButtons(),
              Expanded(child: MoveWindow()),
              const AppBarButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class LeftButtons extends StatelessWidget {
  const LeftButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final connectionProvider = Provider.of<ConnectionStateProvider>(context);
    final joinedAnonymouslyProvider =
        Provider.of<JoinedAnonymouslyProvider>(context);

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
              connectionProvider.closeConnection();
              if (joinedAnonymouslyProvider.joined) {
                joinedAnonymouslyProvider.setJoined(false);
              }
            },
          ),
        ),
        const VerticalDivider(),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Tooltip(
            message: "Status",
            child: Icon(
              switch (connectionProvider.state) {
                ConnectionState.none => Icons.wifi_off,
                _ => Icons.wifi,
              },
              color: switch (connectionProvider.state) {
                ConnectionState.none => Theme.of(context).colorScheme.error,
                ConnectionState.waiting =>
                  Theme.of(context).colorScheme.secondary,
                _ => Theme.of(context).colorScheme.onSurfaceVariant,
              },
            ),
          ),
        ),
      ],
    );
  }
}