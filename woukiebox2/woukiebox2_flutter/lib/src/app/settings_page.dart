import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2_flutter/src/providers/theme_data_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeDataProvider = Provider.of<ThemeDataProvider>(context);

    return Wrap(
      children: [
        Container(
          width: 250,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Switch(
                        value: themeDataProvider.themeMode == ThemeMode.dark,
                        onChanged: (value) =>
                            themeDataProvider.toggleThemeMode(), // Toggle theme
                      ),
                    ),
                    const Text("Dark Mode"),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonalIcon(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        themeDataProvider.updateSelectedColor(
                          await showColorPickerDialog(
                            context,
                            themeDataProvider.color,
                            pickersEnabled: <ColorPickerType, bool>{
                              ColorPickerType.wheel: true,
                              ColorPickerType.accent: false,
                              ColorPickerType.primary: false,
                            },
                            enableShadesSelection: false,
                          ),
                        );
                      },
                      label: const Text("Theme Colour"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
