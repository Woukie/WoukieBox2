import 'package:flutter/material.dart';
import 'package:woukiebox2/src/app/main_app_bar.dart';

import 'chatroom/chat_room.dart';

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
      child: const Column(
        children: [
          MainAppBar(),
          ChatRoom(),
        ],
      ),
    );
  }
}
