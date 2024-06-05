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
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Switch(
                    value: preferenceProvider.themeMode == ThemeMode.dark,
                    onChanged: (value) =>
                        preferenceProvider.toggleThemeMode(), // Toggle theme
                  ),
                ),
                const Text("Dark Mode"),
              ],
            ),
            FilledButton.tonalIcon(
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
              label: const Text("Theme Colour"),
            ),
            FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Fuck my whole shit up")),
            FilledButton(
                onPressed: () {
                  connectionStateProvider.closeConnection();
                },
                child: const Text("Log out")),
          ],
        ),
      ),
    );
  }
}
