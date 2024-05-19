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
        padding: const EdgeInsets.all(8.0),
        color: Colors.amber,
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.deepPurple,
                child: const Text("messages"),
              ),
            ),
            const Text("users"),
          ],
        ),
      ),
    );
  }
}
