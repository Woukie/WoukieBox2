import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/app/profile/profile_editor.dart';
import 'package:woukiebox2/src/app/profile/profile_preview.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/providers/styling_provider.dart';
import 'package:woukiebox2/src/util/hex_color.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

import 'user_item.dart';

class Users extends StatelessWidget {
  const Users({
    super.key,
    required this.userIds,
    required this.showInvisible,
    required this.owners,
  });

  final List<int> userIds;
  final List<int> owners;
  final bool showInvisible;

  @override
  Widget build(BuildContext context) {
    StylingProvider stylingProvider = Provider.of<StylingProvider>(context);
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);
    List<UserClient> users = List<UserClient>.empty(growable: true);

    for (int userId in userIds) {
      UserClient? user = appStateProvider.users[userId];

      if (user == null) {
        user = UserClient(
          id: userId,
          username: "Loading...",
          bio: "Loading...",
          colour:
              (Theme.of(context).textTheme.labelMedium?.color ?? Colors.white)
                  .hex,
          image: "",
          verified: true,
          visible: false,
        );

        appStateProvider.scheduleGetUser(userId);
      }

      if (!showInvisible && !user.visible) continue;

      users.add(user);
    }

    final UserClient? localUser = appStateProvider.currentUser != null
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
                child: UserItem(
                  colour: HexColor.fromHex(localUser.colour),
                  image: localUser.image,
                  username: localUser.username,
                  userId: localUser.id,
                  crowned: owners.contains(localUser.id),
                ),
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
                        Color color = HexColor.fromHex(users[index].colour);
                        UserClient user = users[index];

                        return ProfilePreview(
                          user: user,
                          child: UserItem(
                            disabled: !user.visible,
                            colour: color,
                            image: user.image,
                            username: user.username,
                            userId: user.id,
                            crowned: owners.contains(user.id),
                          ),
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
