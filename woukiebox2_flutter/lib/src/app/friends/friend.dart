import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/main.dart';
import 'package:woukiebox2/src/app/profile/profile_more_dropdown.dart';
import 'package:woukiebox2/src/app/profile/profile_pic.dart';
import 'package:woukiebox2/src/app/profile/profile_preview.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/util/hex_color.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

class Friend extends StatelessWidget {
  const Friend({
    super.key,
    required this.userId,
    this.showNegative = true,
    this.showPositive = true,
    this.positiveIcon = Icons.person_add,
    this.negativeIcon = Icons.person_remove,
  });

  final bool showNegative;
  final bool showPositive;
  final IconData positiveIcon;
  final IconData negativeIcon;
  final int userId;

  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);

    bool loading = appStateProvider.users[userId] == null;

    User user = appStateProvider.users[userId] ??
        User(
          id: userId,
          username: "Loading...",
          bio: "Loading...",
          colour:
              (Theme.of(context).textTheme.labelMedium?.color ?? Colors.white)
                  .hex,
          image: "",
          verified: true,
        );

    return Padding(
      padding: const EdgeInsets.only(right: 12, top: 12),
      child: ProfileMoreDropdown(
        enabled: !loading,
        userId: user.id,
        child: ProfilePreview(
          enabled: !loading,
          user: user,
          child: Card(
            color: Theme.of(context).colorScheme.surfaceContainer,
            elevation: .5,
            margin: EdgeInsets.zero,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ProfilePic(
                    url: user.image,
                  ),
                ),
                Expanded(
                  child: Text(
                    user.username,
                    style: TextStyle(color: HexColor.fromHex(user.colour)),
                    overflow: TextOverflow.fade,
                  ),
                ),
                showNegative
                    ? Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: IconButton.filledTonal(
                          onPressed: () {
                            client.sockets.sendStreamMessage(
                              FriendRequest(target: userId, positive: false),
                            );
                          },
                          icon: Icon(negativeIcon),
                        ),
                      )
                    : Container(),
                showPositive
                    ? Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: IconButton.filled(
                          onPressed: () {
                            client.sockets.sendStreamMessage(
                              FriendRequest(target: userId, positive: true),
                            );
                          },
                          icon: Icon(positiveIcon),
                        ),
                      )
                    : Container(),
                const Padding(padding: EdgeInsets.only(right: 12)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
