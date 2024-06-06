import 'package:flutter/material.dart';
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

    return ConstrainedBox(
      constraints: const BoxConstraints.expand(width: 700),
      child: Column(
        children: [
          Expanded(
            child: Card(
              margin: const EdgeInsets.all(12),
              elevation: 0,
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 12),
                shrinkWrap: true,
                itemCount: appStateProvider.friends.length,
                itemBuilder: (context, index) {
                  return Friend(friendId: index);
                },
              ),
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
