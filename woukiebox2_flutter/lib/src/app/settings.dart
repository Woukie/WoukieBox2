import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/providers/connection_state_provider.dart';
import 'package:woukiebox2/src/providers/preference_provider.dart';

class Settings extends StatelessWidget {
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final connectionStateProvider =
        Provider.of<ConnectionStateProvider>(context);
    final preferenceProvider = Provider.of<PreferenceProvider>(context);

    return ConstrainedBox(
      constraints: const BoxConstraints.expand(width: 700),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Appearance",
                style: TextStyle(fontSize: 22),
              ),

              // Dark Mode
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Dark Mode"),
                  Switch(
                    value: preferenceProvider.themeMode == ThemeMode.dark,
                    onChanged: (value) =>
                        preferenceProvider.toggleThemeMode(), // Toggle theme
                  ),
                ],
              ),
              const Text("Toggle between light and dark mode"),
              const Divider(),

              // Theme Color
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Theme Color"),
                  FilledButton.tonalIcon(
                    label: const Text("Edit"),
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      preferenceProvider.updateSelectedColor(
                        await showColorPickerDialog(
                          context,
                          preferenceProvider.color,
                          pickersEnabled: <ColorPickerType, bool>{
                            ColorPickerType.accent: false,
                            ColorPickerType.primary: true,
                          },
                          enableShadesSelection: false,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const Text(
                  "Select a color to be applied to the styling of the app"),
              const Divider(),

              const Padding(padding: EdgeInsets.all(12)),
              const Text(
                "Notifications",
                style: TextStyle(fontSize: 22),
              ),

              // Toggle Desktop Notifications
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Desktop Notifications"),
                  Switch(
                    value: preferenceProvider.themeMode == ThemeMode.dark,
                    onChanged: (value) =>
                        preferenceProvider.toggleThemeMode(), // Toggle theme
                  ),
                ],
              ),
              const Text("Enable desktop notifications for unread messages"),
              const Divider(),

              // Toggle Desktop Notifications
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Taskbar Flashing"),
                  Switch(
                    value: preferenceProvider.themeMode == ThemeMode.dark,
                    onChanged: (value) =>
                        preferenceProvider.toggleThemeMode(), // Toggle theme
                  ),
                ],
              ),
              const Text(
                  "Enables flashing of the app icon on your taskbar when you get an unread message"),
              const Divider(),

              const Padding(padding: EdgeInsets.all(12)),
              const Text(
                "Misc",
                style: TextStyle(fontSize: 22),
              ),

              FilledButton(
                  onPressed: () {
                    connectionStateProvider.closeConnection();
                  },
                  child: const Text("Log out")),

              FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Fuck my whole shit up")),
            ],
          ),
        ),
      ),
    );
  }
}
