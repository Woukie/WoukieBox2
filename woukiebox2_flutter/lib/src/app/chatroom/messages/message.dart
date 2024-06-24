import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/util/user_util.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart' as client;
import 'package:woukiebox2/src/app/profile/profile_pic.dart';
import 'package:woukiebox2/src/app/profile/profile_preview.dart';
import 'package:woukiebox2/src/util/hex_color.dart';
import 'package:woukiebox2/src/util/written_message.dart';

class Message extends StatelessWidget {
  const Message({super.key, required this.messages, required this.index});

  final List<BaseMessage> messages;
  final int index;

  static String getTimestamp(DateTime time) {
    String prefix = "Today";

    DateTime now = DateTime.now().toUtc();
    bool sentToday =
        time.day == now.day && time.month == now.month && time.year == now.year;

    if (!sentToday) {
      prefix = "Yesterday";

      DateTime yesterday =
          DateTime.now().subtract(const Duration(days: 1)).toUtc();
      bool sentYesterday = time.day == yesterday.day &&
          time.month == yesterday.month &&
          time.year == yesterday.year;

      if (!sentYesterday) {
        prefix = DateFormat('EEE, MMM d, yyyy').format(time.toLocal());
      }
    }

    return '$prefix at ${DateFormat('h:mm a').format(time.toLocal())}';
  }

  @override
  Widget build(BuildContext context) {
    final BaseMessage message = messages[index];
    final BaseMessage? parentMessage =
        index != messages.length - 1 ? messages[index + 1] : null;

    bool newDay =
        parentMessage != null && parentMessage.sentAt.day != message.sentAt.day;

    Widget getRenderedWidget() {
      if (message is ChatMessage) {
        bool child = parentMessage is ChatMessage &&
            parentMessage.senderId == message.senderId &&
            !newDay &&
            !parentMessage.sentAt
                .add(const Duration(minutes: 1, seconds: 30))
                .isBefore(message.sentAt);

        return child
            ? ChildMessage(chatMessage: message)
            : HeadMessage(chatMessage: message);
      } else if (message is LeaveMessage) {
        return SystemMessageWrapper(
          child: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              TextSpan(
                text: message.username,
                style: TextStyle(
                  color: HexColor.fromHex(message.colour),
                ),
              ),
              const TextSpan(
                text: " left the chat",
              ),
            ],
          ),
        );
      } else if (message is KickMessage) {
        client.UserClient sender = UserUtil.getUser(context, message.senderId);
        client.UserClient target = UserUtil.getUser(context, message.target);

        return SystemMessageWrapper(
          child: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              TextSpan(
                text: sender.username,
                style: TextStyle(
                  color: HexColor.fromHex(sender.colour),
                ),
              ),
              const TextSpan(
                text: " kicked ",
              ),
              TextSpan(
                text: target.username,
                style: TextStyle(
                  color: HexColor.fromHex(target.colour),
                ),
              ),
            ],
          ),
        );
      } else if (message is PromoteMessage) {
        client.UserClient sender = UserUtil.getUser(context, message.senderId);
        client.UserClient target = UserUtil.getUser(context, message.target);

        return SystemMessageWrapper(
          child: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              TextSpan(
                text: sender.username,
                style: TextStyle(
                  color: HexColor.fromHex(sender.colour),
                ),
              ),
              const TextSpan(
                text: " promoted ",
              ),
              TextSpan(
                text: target.username,
                style: TextStyle(
                  color: HexColor.fromHex(target.colour),
                ),
              ),
            ],
          ),
        );
      } else if (message is AddUsersMessage) {
        client.UserClient sender = UserUtil.getUser(context, message.senderId);

        List<InlineSpan> usersList = [
          TextSpan(
            text: sender.username,
            style: TextStyle(
              color: HexColor.fromHex(sender.colour),
            ),
          ),
          const TextSpan(
            text: " invited ",
          ),
        ];

        for (int userId in message.users) {
          client.UserClient user = UserUtil.getUser(context, userId);

          usersList.add(
            TextSpan(
              text: user.username,
              style: TextStyle(
                color: HexColor.fromHex(user.colour),
              ),
            ),
          );

          usersList.add(
            TextSpan(
              text: userId == message.users.last
                  ? "."
                  : userId == message.users[message.users.length - 2]
                      ? "and "
                      : ", ",
            ),
          );
        }

        return SystemMessageWrapper(
          child: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: usersList,
          ),
        );
      } else if (message is JoinMessage) {
        return SystemMessageWrapper(
          child: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              TextSpan(
                text: message.username,
                style: TextStyle(
                  color: HexColor.fromHex(message.colour),
                ),
              ),
              const TextSpan(
                text: " joined the chat",
              ),
            ],
          ),
        );
      } else if (message is ProfileMessage) {
        return SystemMessageWrapper(
          child: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              TextSpan(
                text: message.oldUsername,
                style: TextStyle(
                  color: HexColor.fromHex(message.oldColour),
                ),
              ),
              const TextSpan(text: " is now known as "),
              TextSpan(
                text: message.newUsername ?? message.oldUsername,
                style: TextStyle(
                  color:
                      HexColor.fromHex(message.newColour ?? message.oldColour),
                ),
              ),
            ],
          ),
        );
      }

      // This literally cannot happen
      return const Text("unknown chat message :)");
    }

    return Column(
      children: [
        newDay
            ? Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Divider(),
                    ),
                  ),
                  Text(DateFormat('MMMM d, y').format(message.sentAt)),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Divider(),
                    ),
                  ),
                ],
              )
            : Container(),
        getRenderedWidget(),
      ],
    );
  }
}

class SystemMessageWrapper extends StatelessWidget {
  final TextSpan child;

  const SystemMessageWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
        child: Card(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontStyle: FontStyle.italic),
                children: [
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeadMessage extends StatelessWidget {
  final ChatMessage chatMessage;

  const HeadMessage({
    super.key,
    required this.chatMessage,
  });

  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);
    client.UserClient? user = appStateProvider.users[chatMessage.senderId];

    if (user == null) {
      appStateProvider.scheduleGetUser(chatMessage.senderId);
    }

    user ??= UserUtil.getLoading(context, chatMessage.senderId);

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
                url: chatMessage.image ?? user.image,
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
                      chatMessage.username ?? user.username,
                      style: TextStyle(
                        color:
                            HexColor.fromHex(chatMessage.color ?? user.colour),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          Message.getTimestamp(chatMessage.sentAt),
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
                Text(chatMessage.message),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChildMessage extends StatefulWidget {
  final ChatMessage chatMessage;

  const ChildMessage({
    super.key,
    required this.chatMessage,
  });

  @override
  State<ChildMessage> createState() => _ChildMessageState();
}

class _ChildMessageState extends State<ChildMessage> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) => setState(() {
        hovering = true;
      }),
      onExit: (value) => setState(() {
        hovering = false;
      }),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: SizedBox(
              width: 40,
              child: Text(
                !hovering
                    ? ""
                    : DateFormat('HH:mm').format(
                        widget.chatMessage.sentAt.toLocal(),
                      ),
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimaryContainer
                      .withAlpha(75),
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              widget.chatMessage.message,
            ),
          ),
        ],
      ),
    );
  }
}
