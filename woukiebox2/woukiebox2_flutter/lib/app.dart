import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class App extends StatelessWidget {
  final TextStyle? style;

  const App({super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WoukieBox2'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back to login',
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'User Settings',
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        margin:
            const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0, top: 0.0),
        color: Colors.amber,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      color: Colors.deepPurple,
                      child: const Text("messages"),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    color: Colors.yellow,
                    child: const Text("users"),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              color: Colors.pink,
              child: const Text("send messaghe here"),
            ),
          ],
        ),
      ),
    );
  }
}
