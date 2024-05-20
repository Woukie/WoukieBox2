import 'package:flutter/material.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                      child: Messages(),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(left: 12),
                    child: Container(
                      width: 200,
                      alignment: Alignment.topLeft,
                      child: const Users(),
                    ),
                  ),
                ],
              ),
            ),
            const MessageBox()
          ],
        ),
      ),
    );
  }
}

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(top: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: const TextField(
          maxLines: null,
          decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            hintText: "Send Message...",
          ),
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
