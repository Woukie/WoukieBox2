import 'package:flutter/material.dart';

class ThemeDataProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  Color _color = Colors.blue;

  ThemeMode get themeMode => _themeMode;
  Color get color => _color;

  void toggleThemeMode() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void updateSelectedColor(Color color) {
    _color = color;
    notifyListeners();
  }
}
