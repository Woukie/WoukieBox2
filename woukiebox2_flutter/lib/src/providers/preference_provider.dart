import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DesktopNotificationMode { all, mentions, none }

class PreferenceProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  DesktopNotificationMode _desktopNotificationMode =
      DesktopNotificationMode.mentions;
  Color _color = Colors.blue;

  PreferenceProvider() {
    _loadPreferences();
  }

  ThemeMode get themeMode => _themeMode;
  DesktopNotificationMode get desktopNotificationMode =>
      _desktopNotificationMode;
  Color get color => _color;

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

  void updateDesktopNotificationMode(DesktopNotificationMode mode) {
    _desktopNotificationMode = mode;
    _savePreferences();
    notifyListeners();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('themeMode');
    final colorString = prefs.getString('themeColor');
    _desktopNotificationMode =
        switch (prefs.getString('desktopNotificationMode')) {
      'all' => DesktopNotificationMode.all,
      'none' => DesktopNotificationMode.none,
      _ => DesktopNotificationMode.mentions,
    };

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
    prefs.setString('desktopNotificationMode', _desktopNotificationMode.name);
  }
}
