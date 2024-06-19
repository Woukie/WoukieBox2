import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/providers/styling_provider.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

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
    StylingProvider stylingProvider = Provider.of<StylingProvider>(context);
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);

    return Padding(
      padding: EdgeInsets.all(stylingProvider.cardMargin),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: NavigationRail(
              minExtendedWidth: 200,
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
              destinations: <NavigationRailDestination>[
                const NavigationRailDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: Text('Friends'),
                ),
                NavigationRailDestination(
                  icon: _getIconFromList(
                    Icons.outbox_outlined,
                    appStateProvider.outgoingFriendRequests,
                  ),
                  selectedIcon: _getIconFromList(
                    Icons.outbox,
                    appStateProvider.outgoingFriendRequests,
                  ),
                  label: const Text("Outgoing"),
                ),
                NavigationRailDestination(
                  icon: _getIconFromList(
                    Icons.inbox_outlined,
                    appStateProvider.incomingFriendRequests,
                  ),
                  selectedIcon: _getIconFromList(
                    Icons.inbox,
                    appStateProvider.incomingFriendRequests,
                  ),
                  label: const Text("Incoming"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: stylingProvider.cardMargin),
              child: Card(
                margin: EdgeInsets.zero,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 50),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
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
            ),
          ),
        ],
      ),
    );
  }

  _getIconFromList(IconData icon, List list) {
    return list.isEmpty
        ? Icon(icon)
        : Badge(
            label: Text(list.length.toString()),
            child: Icon(icon),
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
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);
    userIds.sort((userA, userB) {
      UserClient? userClientA = appStateProvider.users[userA];
      UserClient? userClientB = appStateProvider.users[userB];

      if ((userClientA == null) || (userClientB == null)) {
        return userA.compareTo(userB);
      }

      if (userClientA.visible != userClientB.visible) {
        return userClientA.visible ? -1 : 1;
      }

      return userClientA.username.compareTo(userClientB.username);
    });

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
