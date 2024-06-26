import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/main.dart';
import 'package:woukiebox2/src/providers/styling_provider.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

class MessageBox extends StatefulWidget {
  const MessageBox({
    super.key,
    required this.target,
    this.enabled = true,
  });

  final int target;
  final bool enabled;

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  final _controller = TextEditingController();

  late final _focusNode = FocusNode(
    onKeyEvent: (FocusNode node, KeyEvent event) {
      if (event is KeyDownEvent &&
          event.logicalKey.keyLabel == "Enter" &&
          !HardwareKeyboard.instance.isShiftPressed) {
        sendMessage(_controller.text, widget.target);
        _controller.clear();
        return KeyEventResult.handled;
      }

      return KeyEventResult.ignored;
    },
  );

  @override
  Widget build(BuildContext context) {
    StylingProvider stylingProvider = Provider.of<StylingProvider>(context);

    return Card(
      elevation: 0,
      margin: EdgeInsets.only(top: stylingProvider.cardMargin),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: TextField(
          controller: _controller,
          maxLines: null,
          decoration: InputDecoration(
            enabled: widget.enabled,
            isDense: true,
            border: InputBorder.none,
            hintText: "Send Message...",
          ),
          onSubmitted: (value) {
            sendMessage(_controller.text, widget.target);
            _controller.clear();
          },
          focusNode: _focusNode,
        ),
      ),
    );
  }
}

void sendMessage(String message, int target) {
  client.sockets.sendStreamMessage(
    ChatMessageClient(
      message: message,
      target: target,
    ),
  );
}
