import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/providers/connection_state_provider.dart';
import 'package:woukiebox2/src/providers/preference_provider.dart';
import 'package:woukiebox2/src/providers/styling_provider.dart';

class Settings extends StatelessWidget {
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    StylingProvider stylingProvider = Provider.of<StylingProvider>(context);
    ConnectionStateProvider connectionStateProvider =
        Provider.of<ConnectionStateProvider>(context);
    PreferenceProvider preferenceProvider =
        Provider.of<PreferenceProvider>(context);

    return ConstrainedBox(
      constraints: const BoxConstraints.expand(width: 700),
      child: Column(
        children: [
          Expanded(
            child: Card(
              margin: EdgeInsets.all(stylingProvider.cardMargin),
              elevation: 0,
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
                      SettingWrapper(
                        title: "Dark Mode",
                        description: "Toggle between light and dark mode",
                        child: Switch(
                          value: preferenceProvider.themeMode == ThemeMode.dark,
                          onChanged: (value) =>
                              preferenceProvider.toggleThemeMode(),
                        ),
                      ),
                      SettingWrapper(
                        title: "Theme Color",
                        description:
                            "Select a color to be applied to the styling of the app",
                        child: FilledButton.tonalIcon(
                          label: const Text("Edit"),
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            preferenceProvider.setSelectedColor(
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
                      ),
                      const Padding(padding: EdgeInsets.all(12)),
                      const Text(
                        "Notifications",
                        style: TextStyle(fontSize: 22),
                      ),
                      SettingWrapper(
                        title: "Receive Notifications",
                        description:
                            "Toggle this off to disable all notifications entirely",
                        child: Switch(
                          value: preferenceProvider.recieveNotifications,
                          onChanged: (value) =>
                              preferenceProvider.setRecieveNotifications(value),
                        ),
                      ),
                      SettingWrapper(
                        title: "In-App Notifications",
                        description:
                            "Enables notifications when in the app for chats that aren't selected",
                        child: Switch(
                          value:
                              kIsWeb || !preferenceProvider.recieveNotifications
                                  ? kIsWeb
                                  : preferenceProvider.inAppNotifications,
                          onChanged:
                              kIsWeb || !preferenceProvider.recieveNotifications
                                  ? null
                                  : (value) => preferenceProvider
                                      .setInAppNotifications(value),
                        ),
                      ),
                      SettingWrapper(
                        title: "Desktop Notifications",
                        description: "Choose to recieve desktop notifications",
                        child: Switch(
                          value:
                              kIsWeb || !preferenceProvider.recieveNotifications
                                  ? false
                                  : preferenceProvider.desktopNotifications,
                          onChanged:
                              kIsWeb || !preferenceProvider.recieveNotifications
                                  ? null
                                  : (value) => preferenceProvider
                                      .setDesktopNotifications(value),
                        ),
                      ),
                      SettingWrapper(
                        title: "Taskbar Flashing",
                        description: "Toggles taskbar flashing on notification",
                        child: Switch(
                          value:
                              kIsWeb || !preferenceProvider.recieveNotifications
                                  ? false
                                  : preferenceProvider.taskbarFlashing,
                          onChanged: kIsWeb ||
                                  !preferenceProvider.recieveNotifications
                              ? null
                              : (value) =>
                                  preferenceProvider.setTaskbarFlashing(value),
                        ),
                      ),
                      SettingWrapper(
                        title: "Notification Sounds",
                        description: "Toggle notification sounds",
                        child: Switch(
                          value: !preferenceProvider.recieveNotifications
                              ? false
                              : preferenceProvider.taskbarFlashing,
                          onChanged: !preferenceProvider.recieveNotifications
                              ? null
                              : (value) =>
                                  preferenceProvider.setTaskbarFlashing(value),
                        ),
                      ),
                      SettingWrapper(
                        title: "Same Chat Notifications",
                        description:
                            "Enables notifications for the chat that you are in",
                        child: Switch(
                          value: !preferenceProvider.recieveNotifications
                              ? false
                              : preferenceProvider.sameChatNotifications,
                          onChanged: !preferenceProvider.recieveNotifications
                              ? null
                              : (value) => preferenceProvider
                                  .setSameChatNotifications(value),
                        ),
                      ),
                      SettingWrapper(
                        title: "Global Notifications",
                        description: "Recieve notifications from global chat",
                        child: Switch(
                          value: !preferenceProvider.recieveNotifications
                              ? false
                              : preferenceProvider.globalNotifications,
                          onChanged: !preferenceProvider.recieveNotifications
                              ? null
                              : (value) => preferenceProvider
                                  .setGlobalNotifications(value),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(12)),
                      const Text(
                        "Advanced Styling",
                        style: TextStyle(fontSize: 22),
                      ),
                      SettingWrapper(
                        title: "Card Margin",
                        description:
                            "Modify the margin of cards to your liking",
                        child: Row(
                          children: [
                            FilledButton.icon(
                              onPressed: () =>
                                  stylingProvider.updateCardMargin(12),
                              label: const Text("Reset"),
                              icon: const Icon(Icons.refresh),
                            ),
                            Slider(
                              min: 0,
                              max: 24,
                              value: stylingProvider.cardMargin,
                              onChanged: (value) =>
                                  stylingProvider.updateCardMargin(value),
                            ),
                          ],
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(12)),
                      const Text(
                        "Misc",
                        style: TextStyle(fontSize: 22),
                      ),
                      SettingWrapper(
                        title: "Log out",
                        description: "Returns you to the log in screen",
                        child: FilledButton(
                          onPressed: () {
                            connectionStateProvider.closeConnection();
                          },
                          child: const Text("Log out"),
                        ),
                      ),
                      SettingWrapper(
                        title: "idfk",
                        description: "Dont press it",
                        child: FilledButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Fuck my whole shit up"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingWrapper extends StatelessWidget {
  const SettingWrapper({
    super.key,
    this.title = "",
    this.description = "",
    required this.child,
  });

  final String title, description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), child],
        ),
        Text(description),
        const Divider(),
      ],
    );
  }
}
