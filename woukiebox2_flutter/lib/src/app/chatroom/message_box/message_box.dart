import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/main.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/providers/styling_provider.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

class MessageBox extends StatefulWidget {
  const MessageBox({super.key});

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StylingProvider stylingProvider = Provider.of<StylingProvider>(context);
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);

    sendMessage(String message) {
      int? target =
          appStateProvider.isGlobal() ? 0 : appStateProvider.selectedChat;
      if (target == null) return;

      client.sockets.sendStreamMessage(
        ChatMessageClient(
          message: message,
          target: target,
        ),
      );
    }

    return Card(
      elevation: 0,
      margin: EdgeInsets.only(top: stylingProvider.cardMargin),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: TextField(
          controller: _controller,
          maxLines: null,
          decoration: InputDecoration(
            enabled: appStateProvider.isGlobal() ||
                appStateProvider.selectedChat != null,
            isDense: true,
            border: InputBorder.none,
            hintText: "Send Message...",
          ),
          onSubmitted: (value) {
            sendMessage(_controller.text);
            _controller.clear();
          },
          focusNode: FocusNode(
            onKeyEvent: (FocusNode node, KeyEvent event) {
              if (event is KeyDownEvent &&
                  event.logicalKey.keyLabel == "Enter" &&
                  !HardwareKeyboard.instance.isShiftPressed) {
                sendMessage(_controller.text);
                _controller.clear();
                return KeyEventResult.handled;
              }

              return KeyEventResult.ignored;
            },
          ),
        ),
      ),
    );
  }
}
