import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/app/profile/profile_more_dropdown.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:woukiebox2/src/app/profile/profile_pic.dart';
import 'package:woukiebox2/src/util/hex_color.dart';

// Wraps a child in an InkWell that opens the profile preview when clicked on
class ProfilePreview extends StatelessWidget {
  const ProfilePreview({
    super.key,
    required this.user,
    required this.child,
  });

  final User user;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).primaryTextTheme.bodyMedium!;
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);

    return InkWell(
      hoverColor: Colors.transparent,
      onTapDown: (TapDownDetails details) async {
        final screenSize = MediaQuery.of(context).size;
        Offset offset = details.globalPosition;

        await showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            offset.dx,
            offset.dy,
            screenSize.width - offset.dx,
            screenSize.height - offset.dy,
          ),
          items: [
            PopupMenuItem(
              enabled: false,
              child: SizedBox(
                width: 200,
                height: 250,
                child: Padding(
                  // Unify the padding from the stock popup
                  padding: const EdgeInsets.only(top: 3, bottom: 3),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ProfilePic(
                            url: user.image,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                style: textStyle.copyWith(
                                  color: HexColor.fromHex(user.colour),
                                ),
                                user.username,
                              ),
                            ),
                          ),
                          PopupMenuButton(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHigh,
                            tooltip: "More",
                            itemBuilder: (BuildContext context) =>
                                ProfileMoreDropdown.getDropdownElements(
                              context,
                              user.id,
                              appStateProvider.friends,
                              appStateProvider.outgoingFriendRequests,
                              appStateProvider.incomingFriendRequests,
                            ),
                            icon: const Icon(Icons.more_horiz),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Card(
                            margin: EdgeInsets.zero,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                        right: 8,
                                        top: 4,
                                        bottom: 4,
                                      ),
                                      child: Text(
                                        user.bio == ""
                                            ? "This user has no bio..."
                                            : user.bio,
                                        style: user.bio == ""
                                            ? const TextStyle(
                                                fontStyle: FontStyle.italic)
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "#${user.id}",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          elevation: 8.0,
        );
      },
      child: child,
    );
  }
}
