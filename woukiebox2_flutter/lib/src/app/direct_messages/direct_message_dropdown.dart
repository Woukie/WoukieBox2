import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';

class DirectMessageDropdown extends StatelessWidget {
  const DirectMessageDropdown({
    super.key,
    required this.child,
    required this.userId,
    this.enabled = true,
  });

  final Widget child;
  final int userId;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);

    return enabled
        ? InkWell(
            borderRadius: BorderRadius.circular(12),
            child: child,
            onSecondaryTapDown: (details) {
              final screenSize = MediaQuery.of(context).size;
              Offset offset = details.globalPosition;

              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  offset.dx,
                  offset.dy,
                  screenSize.width - offset.dx,
                  screenSize.height - offset.dy,
                ),
                items: getDropdownElements(),
              );
            },
          )
        : Container(child: child);
  }

  static List<PopupMenuItem> getDropdownElements() {
    List<PopupMenuItem> items = List.empty(growable: true);

    items.add(getButton("Rename", Icons.person_remove, () => print("Rename")));
    items.add(getButton("Leave", Icons.close, () => print("Leave")));

    return items;
  }

  static getButton(String text, IconData iconData, void Function()? callback) {
    return PopupMenuItem(
      onTap: callback,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(iconData),
          ),
          Text(text),
        ],
      ),
    );
  }
}
