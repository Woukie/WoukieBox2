import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';

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
      elevation: 0,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: NavigationRail(
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
            child: Column(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeScaleTransition(
                          animation: animation, child: child);
                    },
                    child: switch (_selectedIndex) {
                      0 => FriendList(
                          userIds: appStateProvider.friends,
                        ),
                      1 => FriendList(
                          userIds: appStateProvider.outgoingFriendRequests,
                        ),
                      2 => FriendList(
                          userIds: appStateProvider.incomingFriendRequests,
                        ),
                      _ => Container(),
                    },
                  ),
                ),
              ],
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
  });

  final List<int> userIds;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 12),
      shrinkWrap: true,
      itemCount: userIds.length,
      itemBuilder: (context, index) {
        return Friend(userId: userIds[index]);
      },
    );
  }
}

class Friend extends StatelessWidget {
  const Friend({super.key, required this.userId});

  final int userId;

  @override
  Widget build(BuildContext context) {
    return Text("$userId");
  }
}
