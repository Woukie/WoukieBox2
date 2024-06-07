import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:woukiebox2/src/app/friends/friends.dart';
import 'package:woukiebox2/src/app/settings.dart';

import 'chatroom/chat_room.dart';

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          elevation: 2,
          selectedIndex: _selectedIndex,
          labelType: NavigationRailLabelType.selected,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: const <NavigationRailDestination>[
            NavigationRailDestination(
              icon: Icon(Icons.chat_bubble_outline),
              selectedIcon: Icon(Icons.chat_bubble),
              label: Text('Chat'),
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
            child: switch (_selectedIndex) {
              0 => const ChatRoom(),
              1 => const Friends(),
              2 => const Settings(),
              _ => Container(),
            },
          ),
        ),
      ],
    );
  }
}
