import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

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
        child: TitleBar(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              children: [
                Expanded(
                  child: DragToMoveArea(
                    child: Container(),
                  ),
                ),
                kIsWeb ? Container() : const AppBarButtons(),
              ],
            ),
          ),
        ));
  }
}

class TitleBar extends StatelessWidget {
  final Widget? child;
  const TitleBar({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 30, child: child ?? Container());
  }
}
