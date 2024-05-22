import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import '../app_bar_buttons.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: Border.all(color: Colors.transparent, width: 0),
      child: WindowTitleBarBox(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            children: [
              const AppBarButtons(),
              Expanded(child: MoveWindow()),
              const Controls(),
            ],
          ),
        ),
      ),
    );
  }
}

class Controls extends StatelessWidget {
  const Controls({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: IconButton(
            icon: const Icon(Icons.remove),
            padding: EdgeInsets.zero,
            onPressed: () {
              appWindow.minimize();
            },
          ),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: IconButton(
            icon: const Icon(Icons.fullscreen),
            padding: EdgeInsets.zero,
            onPressed: () {
              appWindow.maximizeOrRestore();
            },
          ),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: IconButton(
            icon: const Icon(Icons.close),
            padding: EdgeInsets.zero,
            onPressed: () {
              appWindow.close();
            },
          ),
        ),
      ],
    );
  }
}
