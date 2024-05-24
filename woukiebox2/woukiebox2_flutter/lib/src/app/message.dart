import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:woukiebox2_flutter/src/providers/connection_state_provider.dart';
import 'package:woukiebox2_flutter/src/util/hex_color.dart';
import 'package:woukiebox2_flutter/src/util/written_message.dart';

User unknownUser = User(
  id: -1,
  username: "Unknown User",
  bio: "",
  colour: "#FF0000",
  verified: false,
  visible: false,
);

class Message extends StatelessWidget {
  const Message({super.key, required this.messages, required this.index});

  final List<dynamic> messages;
  final int index;

  @override
  Widget build(BuildContext context) {
    final message = messages[index];
    final parentMessage = index != 0 ? messages[index - 1] : null;

    if (message is WrittenMessage) {
      bool typeMatch = parentMessage is WrittenMessage;

      bool child = typeMatch && parentMessage.senderId == message.senderId;

      return child
          ? ChildMessage(message: messages[index])
          : HeadMessage(message: messages[index]);
    }

    // Reserved for system messages with specific styling intent
    if (message is TextSpan) {
      return SystemMessageWrapper(child: message);
    }

    // This literally cannot happen
    return const Text("unknown chat message :)");
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
  const HeadMessage({super.key, required this.message});

  final WrittenMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: CircleAvatar(
              radius: 20,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.username,
                  style: TextStyle(color: HexColor.fromHex(message.colour)),
                ),
                Text(message.message),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChildMessage extends StatelessWidget {
  const ChildMessage({super.key, required this.message});

  final WrittenMessage message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Container(
            width: 40,
          ),
        ),
        Expanded(
          child: Text(
            message.message,
          ),
        ),
      ],
    );
  }
}
