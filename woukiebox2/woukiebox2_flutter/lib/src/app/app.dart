import 'package:flutter/material.dart';
import 'package:woukiebox2_flutter/main.dart';

import 'chat_box.dart';
import 'bar/app_bar.dart';

class App extends StatelessWidget {
  final TextStyle? style;

  const App({super.key, this.style});

  @override
  Widget build(BuildContext context) {
    client.openStreamingConnection();

    return Card(
      elevation: 0.5,
      shape: Border.all(width: 0, color: Colors.transparent),
      margin: const EdgeInsets.all(0),
      child: const Column(
        children: [
          WoukieAppBar(),
          ChatBox(),
        ],
      ),
    );
  }
}
