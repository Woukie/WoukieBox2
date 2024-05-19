import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final TextStyle? style;

  const App({super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      "welcome to the app!",
      style: style,
    );
  }
}
