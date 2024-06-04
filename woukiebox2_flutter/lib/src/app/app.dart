import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:woukiebox2/src/app/main_app_bar.dart';
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
    return Card(
      elevation: 0.5,
      shape: Border.all(width: 0, color: Colors.transparent),
      margin: const EdgeInsets.all(0),
      child: Column(
        children: [
          const MainAppBar(),
          Expanded(
            child: Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  destinations: const <NavigationRailDestination>[
                    NavigationRailDestination(
                      icon: Icon(Icons.chat_bubble_outline),
                      selectedIcon: Icon(Icons.chat_bubble),
                      label: Text('First'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings),
                      label: Text('First'),
                    ),
                  ],
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: switch (_selectedIndex) {
                      0 => const ChatRoom(),
                      1 => const Settings(),
                      _ => Container(),
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
