import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

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
