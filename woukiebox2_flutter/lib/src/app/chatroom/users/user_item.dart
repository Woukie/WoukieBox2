import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/app/profile/profile_dropdown.dart';
import 'package:woukiebox2/src/app/profile/profile_pic.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/util/user_util.dart';
import 'package:woukiebox2/src/util/group_chat.dart';
import 'package:woukiebox2/src/util/hex_color.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.userId,
  });

  final int userId;

  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);

    UserClient user = UserUtil.getUser(context, userId);

    GroupChat? chat = appStateProvider.chats[appStateProvider.selectedChat];

    bool crowned = !appStateProvider.isGlobalChatSelected() &&
        chat != null &&
        chat.owners.contains(userId);
    int alpha = user.visible ? 255 : 90;

    return ProfileDropdown.rightClickWrapper(
      context,
      userId,
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProfilePic(
              offline: !user.visible,
              url: user.image,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                softWrap: false,
                overflow: TextOverflow.fade,
                maxLines: 1,
                user.username,
                style: TextStyle(
                  color: Color.lerp(HexColor.fromHex(user.colour), Colors.grey,
                          !user.visible ? 0.7 : 0)
                      ?.withAlpha(alpha),
                ),
              ),
            ),
          ),
          crowned
              ? Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.shield,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant
                        .withAlpha(alpha),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
