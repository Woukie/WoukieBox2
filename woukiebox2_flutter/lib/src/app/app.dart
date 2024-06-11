import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/app/friends/friends.dart';
import 'package:woukiebox2/src/app/settings.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';

import 'chatroom/chat_room.dart';

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);
    int selectedPage = appStateProvider.selectedPage;

    return Row(
      children: [
        NavigationRail(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
          elevation: 2,
          selectedIndex: selectedPage,
          labelType: NavigationRailLabelType.selected,
          onDestinationSelected: (int index) {
            appStateProvider.setSelectedPage(index);
          },
          destinations: const <NavigationRailDestination>[
            NavigationRailDestination(
              icon: Icon(Icons.public_outlined),
              selectedIcon: Icon(Icons.public),
              label: Text('Global'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.chat_bubble_outline),
              selectedIcon: Icon(Icons.chat_bubble),
              label: Text('Messages'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.group_outlined),
              selectedIcon: Icon(Icons.group),
              label: Text('Friends'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: Text('Settings'),
            ),
          ],
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeScaleTransition(animation: animation, child: child);
            },
            child: switch (selectedPage) {
              0 || 1 => ChatRoom(
                  global: selectedPage == 0,
                ),
              2 => const Friends(),
              3 => const Settings(),
              _ => Container(),
            },
          ),
        ),
      ],
    );
  }
}
