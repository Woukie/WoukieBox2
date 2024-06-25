import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/main.dart';
import 'package:woukiebox2/src/app/profile/profile_dropdown.dart';
import 'package:woukiebox2/src/app/profile/profile_pic.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/util/hex_color.dart';
import 'package:woukiebox2/src/util/user.dart';
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

    User user = User.getUser(context, userId);

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: ProfileDropdown.rightClickWrapper(
        context,
        user.id,
        Card(
          color: Theme.of(context).colorScheme.surfaceContainer,
          elevation: .5,
          margin: EdgeInsets.zero,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              bool found = false;
              appStateProvider.chats.forEach((id, chat) {
                if (chat.users.length == 2 && chat.users.contains(user.id)) {
                  appStateProvider.setSelectedGroup(id);
                  appStateProvider.setSelectedPage(1);
                  found = true;
                }
              });

              if (!found) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                    actionsPadding: const EdgeInsets.all(12),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    content:
                        const Text("Create a group with you and this person?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          client.sockets.sendStreamMessage(
                            NetworkChatMessage(
                              action: MessageType.Create,
                              targets: [userId].toList(),
                              chat: 0,
                            ),
                          );
                        },
                        child: const Text("Create"),
                      )
                    ],
                  ),
                );
              }
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ProfilePic(
                    url: user.image,
                    offline: !user.visible,
                    imageEffects: false,
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
                              FriendRequestClient(
                                target: userId,
                                positive: false,
                              ),
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
                              FriendRequestClient(
                                target: userId,
                                positive: true,
                              ),
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
