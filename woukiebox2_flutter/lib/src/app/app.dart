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
      child: Column(
        children: [
          const MainAppBar(),
          Expanded(
            child: Navigator(
              initialRoute: "chatroom",
              onGenerateRoute: (RouteSettings settings) {
                WidgetBuilder builder;

                switch (settings.name) {
                  case 'chatroom':
                    builder = (BuildContext context) => const ChatRoom();
                  case 'settings':
                    builder = (BuildContext context) => const Settings();
                  default:
                    throw Exception('Invalid route: ${settings.name}');
                }

                return MaterialPageRoute<void>(
                  builder: builder,
                  settings: settings,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
