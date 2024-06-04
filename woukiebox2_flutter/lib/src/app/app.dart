import 'package:flutter/material.dart';
import 'package:woukiebox2/src/app/main_app_bar.dart';

import 'chatroom/message_box/message_box.dart';
import 'chatroom/messages/messages.dart';
import 'chatroom/users/users.dart';

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: Border.all(width: 0, color: Colors.transparent),
      margin: const EdgeInsets.all(0),
      child: Column(
        children: [
          const MainAppBar(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Expanded(
                          child: Card(
                            margin: EdgeInsets.all(0.0),
                            elevation: 0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Messages(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          alignment: Alignment.topLeft,
                          child: const Users(),
                        ),
                      ],
                    ),
                  ),
                  const MessageBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
