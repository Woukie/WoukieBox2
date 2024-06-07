import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';

import 'friend.dart';

class Friends extends StatefulWidget {
  const Friends({
    super.key,
  });

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appStateProvider = Provider.of<AppStateProvider>(context);

    return Card(
      margin: const EdgeInsets.all(12),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      elevation: 0,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: NavigationRail(
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerLow,
              labelType: NavigationRailLabelType.none,
              selectedIndex: _selectedIndex,
              extended: true,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: Text('Friends'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.outbox_outlined),
                  selectedIcon: Icon(Icons.outbox),
                  label: Text("Outgoing"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.inbox_outlined),
                  selectedIcon: Icon(Icons.inbox),
                  label: Text("Incoming"),
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: switch (_selectedIndex) {
                0 => FriendList(
                    key: const Key("friends"),
                    userIds: appStateProvider.friends,
                    showNegative: true,
                  ),
                1 => FriendList(
                    key: const Key("outgoingFriendRequests"),
                    userIds: appStateProvider.outgoingFriendRequests,
                    showNegative: true,
                    negativeIcon: Icons.close,
                  ),
                2 => FriendList(
                    key: const Key("incomingFriendRequests"),
                    userIds: appStateProvider.incomingFriendRequests,
                    showPositive: true,
                    showNegative: true,
                    negativeIcon: Icons.person_off,
                  ),
                _ => Container(),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FriendList extends StatelessWidget {
  const FriendList({
    super.key,
    required this.userIds,
    this.showNegative = false,
    this.showPositive = false,
    this.positiveIcon = Icons.person_add,
    this.negativeIcon = Icons.person_remove,
  });

  final bool showNegative;
  final bool showPositive;
  final IconData positiveIcon;
  final IconData negativeIcon;

  final List<int> userIds;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      prototypeItem: const Friend(userId: -1),
      padding: const EdgeInsets.only(bottom: 12),
      itemCount: userIds.length,
      itemBuilder: (context, index) {
        return Friend(
          userId: userIds[index],
          showNegative: showNegative,
          showPositive: showPositive,
          positiveIcon: positiveIcon,
          negativeIcon: negativeIcon,
        );
      },
    );
  }
}
