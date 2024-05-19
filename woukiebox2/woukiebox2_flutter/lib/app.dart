import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final TextStyle? style;

  const App({super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: Border.all(width: 0, color: Colors.transparent),
      margin: const EdgeInsets.all(0),
      child: const Column(
        children: [
          AppBar(),
          ChatBox(),
        ],
      ),
    );
  }
}

class ChatBox extends StatelessWidget {
  const ChatBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  const Expanded(
                    child: Card(
                      margin: EdgeInsets.all(0.0),
                      elevation: 0,
                      child: Messages(),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      width: 200,
                      alignment: Alignment.topLeft,
                      child: const Users(),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 0,
              margin: const EdgeInsets.only(top: 8),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "Send Message...",
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: Border.all(color: Colors.transparent, width: 0),
      child: WindowTitleBarBox(
        child: Row(
          children: [
            const Text(
              "WoukieBox2",
            ),
            Expanded(child: MoveWindow()),
            IconButton(
              icon: const Icon(
                Icons.account_circle_outlined,
              ),
              tooltip: 'User Settings',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class Messages extends StatelessWidget {
  const Messages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var items = List<String>.generate(10000, (i) => 'Message $i');

    return ListView.builder(
      reverse: true,
      itemCount: items.length,
      prototypeItem: const ListTile(
        title: Text("Test Message!"),
      ),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index]),
        );
      },
    );
  }
}

class Users extends StatelessWidget {
  const Users({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var items = List<String>.generate(10000, (i) => 'User $i');

    return ListView.builder(
      itemCount: items.length,
      prototypeItem: const ListTile(
        title: Text("Test Message!"),
      ),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index]),
        );
      },
    );
  }
}
