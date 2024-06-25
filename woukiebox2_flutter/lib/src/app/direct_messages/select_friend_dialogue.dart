import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/app/profile/profile_pic.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/util/user.dart';

class SelectFriendDialogue {
  static Future<void> showDialogue(
    BuildContext context,
    Function(List<int>) callback,
    String titleText,
    String submitText,
    int? excludeChat,
  ) {
    HashMap<int, bool> friendsSelection = HashMap<int, bool>();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        AppStateProvider appStateProvider =
            Provider.of<AppStateProvider>(context);

        List<int> friends = appStateProvider.friends;
        List<int> exclude = appStateProvider.chats.containsKey(excludeChat)
            ? appStateProvider.chats[excludeChat]!.users
            : List.empty();

        HashMap<int, bool> updatedSelection = HashMap<int, bool>();
        for (var friend in friends) {
          if (!exclude.contains(friend)) {
            updatedSelection[friend] = friendsSelection[friend] ?? false;
          }
        }
        friendsSelection = updatedSelection;

        var friendsList = friendsSelection.keys.toList();
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
                        Text(titleText),
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                            itemCount: friendsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              int friendId = friendsList[index];

                              User user = User.getUser(context, friendId);

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
                                        url: user.image,
                                        offline: user.visible,
                                        showIndicator: false,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 8),
                                      ),
                                      Expanded(
                                        child: Text(
                                          style: TextStyle(
                                            color: user.getColor(),
                                          ),
                                          user.username,
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
                                callback(List.of(friendsSelection.keys));
                                Navigator.of(context).pop();
                              },
                              child: Text(submitText),
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
