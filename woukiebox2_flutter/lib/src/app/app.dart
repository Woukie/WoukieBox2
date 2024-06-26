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
  static final Animatable<double> _fadeOutTransition = Tween<double>(
    begin: 1.0,
    end: 0.0,
  );

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
            duration: const Duration(milliseconds: 150),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return DualTransitionBuilder(
                animation: animation,
                forwardBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Widget? child,
                ) {
                  return SlideTransition(
                    position: Tween(
                      begin: const Offset(0, 1),
                      end: const Offset(0, 0),
                    ).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                reverseBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Widget? child,
                ) {
                  return FadeTransition(
                    opacity: _fadeOutTransition.animate(animation),
                    child: SlideTransition(
                      position: Tween(
                        begin: const Offset(0, 0),
                        end: const Offset(0, 0.1),
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: child,
              );
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
