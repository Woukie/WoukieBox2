import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WoukieAppBar extends StatelessWidget {
  const WoukieAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return Container();
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: Border.all(color: Colors.transparent, width: 0),
      child: SizedBox(
        height: 30,
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Row(
            children: [
              Expanded(
                child: DragToMoveArea(
                  child: Container(),
                ),
              ),
              Row(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
