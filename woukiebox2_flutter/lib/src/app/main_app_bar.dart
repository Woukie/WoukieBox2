import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:woukiebox2/main.dart';
import 'package:woukiebox2/src/app/profile_page.dart';
import 'package:woukiebox2/src/app/settings_page.dart';
import 'package:woukiebox2/src/providers/connection_state_provider.dart';

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
        child: TitleBar(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              children: [
                const LeftButtons(),
                Expanded(
                  child: DragToMoveArea(
                    child: Container(),
                  ),
                ),
                kIsWeb ? Container() : const AppBarButtons(),
              ],
            ),
          ),
        ));
  }
}

class TitleBar extends StatelessWidget {
  final Widget? child;
  const TitleBar({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 30, child: child ?? Container());
  }
}

class LeftButtons extends StatelessWidget {
  const LeftButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final connectionProvider = Provider.of<ConnectionStateProvider>(context);

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
            },
          ),
        ),
        const VerticalDivider(),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Tooltip(
            message: "Status",
            child: Icon(
              switch (connectionProvider.connectionHandler.status.status) {
                StreamingConnectionStatus.connected => Icons.wifi,
                StreamingConnectionStatus.disconnected => Icons.wifi_off,
                StreamingConnectionStatus.connecting => Icons.wifi_2_bar,
                StreamingConnectionStatus.waitingToRetry => Icons.timer,
              },
              color: switch (
                  connectionProvider.connectionHandler.status.status) {
                StreamingConnectionStatus.connected =>
                  Theme.of(context).colorScheme.onSurfaceVariant,
                StreamingConnectionStatus.disconnected =>
                  Theme.of(context).colorScheme.error,
                StreamingConnectionStatus.connecting =>
                  Theme.of(context).colorScheme.secondary,
                StreamingConnectionStatus.waitingToRetry =>
                  Theme.of(context).colorScheme.secondary,
              },
            ),
          ),
        ),
        Text(
          "${connectionProvider.connectionHandler.status.retryInSeconds ?? ""}",
        ),
      ],
    );
  }
}
