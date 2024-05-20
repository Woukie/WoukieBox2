import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeDataProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  Color _color = Colors.blue;

  ThemeDataProvider() {
    _loadPreferences();
  }

  ThemeMode get themeMode => _themeMode;
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

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('themeMode');
    final colorString = prefs.getString('themeColor');

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
  }
}
