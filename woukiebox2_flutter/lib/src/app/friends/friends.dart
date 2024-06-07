import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/providers/preference_provider.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

class Friends extends StatelessWidget {
  const Friends({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appStateProvider = Provider.of<AppStateProvider>(context);

    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 0,
      child: Row(
        children: [
          NavigationRail(
            backgroundColor: Theme.of(context).cardColor,
            selectedIndex: 0,
            extended: true,
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
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 12),
                    shrinkWrap: true,
                    itemCount: appStateProvider.friends.length,
                    itemBuilder: (context, index) {
                      return Friend(friendId: index);
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

class Friend extends StatelessWidget {
  const Friend({super.key, required this.friendId});

  final int friendId;

  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);

    return Text("$friendId");
  }
}
