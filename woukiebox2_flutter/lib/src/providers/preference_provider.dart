import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum MessageSoundMode { all, unfocussed, none }

class PreferenceProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  MessageSoundMode _messageSoundMode = MessageSoundMode.all;
  bool _taskbarFlashing = true;
  bool _desktopNotifications = true;
  Color _color = Colors.blue;

  PreferenceProvider() {
    _loadPreferences();
  }

  ThemeMode get themeMode => _themeMode;
  MessageSoundMode get messageSoundMode => _messageSoundMode;
  Color get color => _color;
  bool get taskbarFlashing => _taskbarFlashing;
  bool get desktopNotifications => _desktopNotifications;

  void toggleThemeMode() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _savePreferences();
    notifyListeners();
  }

  void updateSelectedColor(Color color) {
    _color = color;
    _savePreferences();
    notifyListeners();
  }

  void updateTaskbarFlashing(bool taskbarFlashing) {
    _taskbarFlashing = taskbarFlashing;
    _savePreferences();
    notifyListeners();
  }

  void updateDesktopNotifications(bool desktopNotifications) {
    _desktopNotifications = desktopNotifications;
    _savePreferences();
    notifyListeners();
  }

  void updateMessageSoundMode(MessageSoundMode mode) {
    _messageSoundMode = mode;
    _savePreferences();
    notifyListeners();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('themeMode');
    final colorString = prefs.getString('themeColor');
    final desktopNotifications = prefs.getBool('desktopNotifications');
    final taskbarFlashing = prefs.getBool('taskbarFlashing');

    _messageSoundMode = switch (prefs.getString('messageSoundMode')) {
      'all' => MessageSoundMode.all,
      'none' => MessageSoundMode.none,
      _ => MessageSoundMode.unfocussed,
    };

    if (desktopNotifications != null) {
      _desktopNotifications = desktopNotifications;
    }

    if (taskbarFlashing != null) {
      _taskbarFlashing = taskbarFlashing;
    }

    if (themeModeString != null) {
      _themeMode = ThemeMode.values[int.parse(themeModeString)];
    }

    if (colorString != null) {
      _color = Color(int.parse(colorString));
    }

    notifyListeners();
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', _themeMode.index.toString());
    prefs.setString('themeColor', _color.value.toString());
    prefs.setString('messageSoundMode', _messageSoundMode.name);
    prefs.setBool('desktopNotifications', _desktopNotifications);
    prefs.setBool('taskbarFlashing', _taskbarFlashing);
  }
}
