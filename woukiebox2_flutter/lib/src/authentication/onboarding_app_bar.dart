import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../app_bar_buttons.dart';

class OnboardingAppBar extends StatelessWidget {
  const OnboardingAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              const AppBarButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
