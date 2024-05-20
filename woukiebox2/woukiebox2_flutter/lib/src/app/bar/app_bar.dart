import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import 'controls.dart';
import 'operations.dart';

class WoukieAppBar extends StatelessWidget {
  const WoukieAppBar({
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
              const Operations(),
              Expanded(child: MoveWindow()),
              const Controls(),
            ],
          ),
        ),
      ),
    );
  }
}
