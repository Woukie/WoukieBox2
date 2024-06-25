import 'package:flutter/material.dart';
import 'package:woukiebox2/src/app/chatroom/messages/message.dart';
import 'package:woukiebox2/src/app/profile/profile_pic.dart';
import 'package:woukiebox2/src/app/profile/profile_preview.dart';
import 'package:woukiebox2/src/util/hex_color.dart';
import 'package:woukiebox2/src/util/user.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

class HeadMessage extends StatelessWidget {
  final NetworkChatMessage chatMessage;

  const HeadMessage({
    super.key,
    required this.chatMessage,
  });

  @override
  Widget build(BuildContext context) {
    User user = User.getUser(context, chatMessage.sender);

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: ProfilePreview(
              user: user,
              child: ProfilePic(
                url: user.image,
                offline: false,
                showIndicator: false,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      user.username,
                      style: TextStyle(
                        color: HexColor.fromHex(user.colour),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          Message.getTimestamp(chatMessage.sentAt!),
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer
                                .withAlpha(75),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Text(chatMessage.message!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
