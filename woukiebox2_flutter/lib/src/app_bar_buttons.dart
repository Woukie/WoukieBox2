import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AppBarButtons extends StatelessWidget {
  const AppBarButtons({
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
              windowManager.minimize();
            },
          ),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: IconButton(
            icon: const Icon(Icons.fullscreen),
            padding: EdgeInsets.zero,
            onPressed: () {
              windowManager.maximize();
            },
          ),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: IconButton(
            icon: const Icon(Icons.close),
            padding: EdgeInsets.zero,
            onPressed: () {
              windowManager.close();
            },
          ),
        ),
      ],
    );
  }
}
