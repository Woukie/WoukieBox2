import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:woukiebox2_flutter/main.dart';

class WoukieAppBar extends StatelessWidget {
  const WoukieAppBar({
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
              AspectRatio(
                aspectRatio: 1,
                child: IconButton(
                  icon: const Icon(
                    Icons.account_circle_outlined,
                  ),
                  padding: EdgeInsets.zero,
                  tooltip: 'Profile',
                  onPressed: () {},
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
                  onPressed: () {},
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
              Expanded(child: MoveWindow()),
              Row(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: IconButton(
                      icon: const Icon(Icons.remove),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        appWindow.minimize();
                      },
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 1,
                    child: IconButton(
                      icon: const Icon(Icons.fullscreen),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        appWindow.maximizeOrRestore();
                      },
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 1,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        appWindow.close();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
