import 'package:flutter/material.dart';
import 'package:woukiebox2/src/app/main_app_bar.dart';
import 'package:woukiebox2/src/app/settings.dart';

import 'chatroom/chat_room.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: Border.all(width: 0, color: Colors.transparent),
      margin: const EdgeInsets.all(0),
      child: const Column(
        children: [
          MainAppBar(),
          DefaultTabController(
            length: 2,
            child: TabBarView(
              children: [
                ChatRoom(),
                Settings(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
