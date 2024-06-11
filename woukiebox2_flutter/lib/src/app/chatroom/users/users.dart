import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/app/profile/profile_editor.dart';
import 'package:woukiebox2/src/app/profile/profile_preview.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/util/hex_color.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

import 'user_item.dart';

class Users extends StatelessWidget {
  const Users({
    super.key,
    required this.userIds,
    required this.showInvisible,
    this.crown = 0,
  });

  final List<int> userIds;
  final bool showInvisible;
  final int crown;

  @override
  Widget build(BuildContext context) {
    final appStateProvider = Provider.of<AppStateProvider>(context);
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

    // app only renders if user passes null check
    final UserClient localUser =
        appStateProvider.users[appStateProvider.currentUser]!;
    users.removeWhere((user) => user == localUser);

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ProfileEditor(
              user: localUser,
              child: Card(
                margin: EdgeInsets.zero,
                child: UserItem(
                  colour: HexColor.fromHex(localUser.colour),
                  image: localUser.image,
                  username: localUser.username,
                  userId: localUser.id,
                  crowned: crown == localUser.id,
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
                            colour: color,
                            image: user.image,
                            username: user.username,
                            userId: user.id,
                            crowned: crown == user.id,
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
