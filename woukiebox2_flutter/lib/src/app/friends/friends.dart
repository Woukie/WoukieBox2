import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/main.dart';
import 'package:woukiebox2/src/app/profile/profile_pic.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

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
                    negativeCallback: (userId) {
                      client.sockets.sendStreamMessage(
                        FriendRequest(target: userId, positive: false),
                      );
                    },
                  ),
                1 => FriendList(
                    key: const Key("outgoingFriendRequests"),
                    userIds: appStateProvider.outgoingFriendRequests,
                    negativeCallback: (userId) {
                      client.sockets.sendStreamMessage(
                        FriendRequest(target: userId, positive: false),
                      );
                    },
                  ),
                2 => FriendList(
                    key: const Key("incomingFriendRequests"),
                    userIds: appStateProvider.incomingFriendRequests,
                    positiveCallback: (userId) {
                      client.sockets.sendStreamMessage(
                        FriendRequest(target: userId, positive: true),
                      );
                    },
                    negativeCallback: (userId) {
                      client.sockets.sendStreamMessage(
                        FriendRequest(target: userId, positive: false),
                      );
                    },
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
    this.positiveCallback,
    this.negativeCallback,
  });

  final Function(int userId)? positiveCallback;
  final Function(int userId)? negativeCallback;
  final List<int> userIds;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      prototypeItem: const Friend(userId: 1),
      padding: const EdgeInsets.only(bottom: 12),
      itemCount: userIds.length,
      itemBuilder: (context, index) {
        return Friend(
          userId: userIds[index],
          positiveCallback: positiveCallback,
          negativeCallback: negativeCallback,
        );
      },
    );
  }
}

class Friend extends StatelessWidget {
  const Friend(
      {super.key,
      required this.userId,
      this.positiveCallback,
      this.negativeCallback});

  final Function(int userId)? positiveCallback;
  final Function(int userId)? negativeCallback;

  final int userId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, top: 12),
      child: Card(
        elevation: .5,
        margin: EdgeInsets.zero,
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(12),
              child: ProfilePic(
                url:
                    "https://www.gannett-cdn.com/-mm-/968b2fdbf02baeb86111b3ffda77ca1822b5d9ba/c=0-875-1854-2269&r=x513&c=680x510/local/-/media/USATODAY/USATODAY/2014/09/09/1410265931002-911aniv14_002.jpg",
              ),
            ),
            Expanded(
              child: Text(
                "$userId",
                overflow: TextOverflow.fade,
              ),
            ),
            negativeCallback != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: IconButton.filledTonal(
                      onPressed: () {
                        negativeCallback!(userId);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  )
                : Container(),
            positiveCallback != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: IconButton.filled(
                      onPressed: () {
                        positiveCallback!(userId);
                      },
                      icon: const Icon(Icons.check),
                    ),
                  )
                : Container(),
            const Padding(padding: EdgeInsets.only(right: 12)),
          ],
        ),
      ),
    );
  }
}
