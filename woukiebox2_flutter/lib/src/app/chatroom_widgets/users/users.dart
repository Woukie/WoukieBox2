import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/app/profile/profile_editor.dart';
import 'package:woukiebox2/src/app/profile/profile_preview.dart';
import 'package:woukiebox2/src/providers/connection_state_provider.dart';
import 'package:woukiebox2/src/util/hex_color.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

import 'user_item.dart';

class Users extends StatelessWidget {
  const Users({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final connectionStateProvider =
        Provider.of<ConnectionStateProvider>(context);
    final users = connectionStateProvider.users;
    final List<User> userList = users.values.toList();
    // app only renders if user passes null check
    final User localUser = users[connectionStateProvider.currentUser]!;
    userList
        .removeWhere((user) => !(user.visible ?? true) || user == localUser);

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
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        Color color = HexColor.fromHex(userList[index].colour);
                        User user = userList[index];

                        return ProfilePreview(
                          user: user,
                          child: UserItem(
                            colour: color,
                            image: user.image,
                            username: user.username,
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
