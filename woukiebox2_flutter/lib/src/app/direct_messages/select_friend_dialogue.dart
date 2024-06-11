import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/main.dart';
import 'package:woukiebox2/src/app/profile/profile_pic.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/util/hex_color.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

class SelectFriendDialogue {
  static Future<void> showDialogue(BuildContext context) {
    HashMap<int, bool> friendsSelection = HashMap<int, bool>();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        AppStateProvider appStateProvider =
            Provider.of<AppStateProvider>(context);

        List<int> friends = appStateProvider.friends;

        HashMap<int, bool> updatedSelection = HashMap<int, bool>();
        for (var friend in friends) {
          updatedSelection[friend] = friendsSelection[friend] ?? false;
        }
        friendsSelection = updatedSelection;

        return StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Select Contacts"),
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                            itemCount: friends.length,
                            itemBuilder: (BuildContext context, int index) {
                              int friendId = friends[index];

                              UserClient? user =
                                  appStateProvider.users[friendId];

                              if (user == null) {
                                appStateProvider.scheduleGetUser(friendId);
                              }

                              return InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  setState(() {
                                    friendsSelection[friendId] =
                                        !friendsSelection[friendId]!;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      ProfilePic(
                                        url: user == null ? "" : user.image,
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(right: 8)),
                                      Expanded(
                                        child: Text(
                                          style: TextStyle(
                                            color: user == null
                                                ? null
                                                : HexColor.fromHex(user.colour),
                                          ),
                                          user == null
                                              ? "Loading..."
                                              : user.username,
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(right: 8)),
                                      Checkbox(
                                        value: friendsSelection[friendId],
                                        onChanged: (value) {
                                          if (value == null) return;
                                          setState(() {
                                            friendsSelection[friendId] = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(right: 8)),
                            FilledButton(
                              onPressed: () {
                                friendsSelection
                                    .removeWhere((user, selected) => !selected);
                                client.sockets.sendStreamMessage(
                                  CreateChatClient(
                                    users: List.of(friendsSelection.keys),
                                  ),
                                );

                                Navigator.of(context).pop();
                              },
                              child: const Text('Create'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
