import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/app/profile/profile_editor.dart';
import 'package:woukiebox2/src/app/profile/profile_preview.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/providers/styling_provider.dart';
import 'package:woukiebox2/src/util/group_chat.dart';
import 'package:woukiebox2/src/util/user.dart';

import 'user_item.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    StylingProvider stylingProvider = Provider.of<StylingProvider>(context);
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);

    GroupChat? groupChat =
        appStateProvider.chats[appStateProvider.selectedChat];
    List<User> users = List.empty(growable: true);

    if (appStateProvider.selectedPage == 0) {
      users = appStateProvider.users.values.toList();
      users.removeWhere((user) => !user.visible);
    } else if (appStateProvider.chats.containsKey(
      appStateProvider.selectedChat,
    )) {
      for (int userId in groupChat!.users) {
        users.add(User.getUser(context, userId));
      }
    }

    final User? localUser = appStateProvider.currentUser != null
        ? appStateProvider.users[appStateProvider.currentUser!]
        : null;

    if (localUser == null) return Container();

    users.removeWhere((user) => user == localUser);
    users.sort((userA, userB) {
      if (userA.visible != userB.visible) return userA.visible ? -1 : 1;
      return userA.username.compareTo(userB.username);
    });

    return Padding(
      padding: EdgeInsets.only(left: stylingProvider.cardMargin),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: stylingProvider.cardMargin),
            child: ProfileEditor(
              user: localUser,
              child: Card(
                margin: EdgeInsets.zero,
                child: UserItem(userId: localUser.id),
              ),
            ),
          ),
          Expanded(
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        User user = users[index];

                        return ProfilePreview(
                          user: user,
                          child: UserItem(userId: user.id),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
