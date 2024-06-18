import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceProvider extends ChangeNotifier {
  bool _recieveNotifications = true;
  bool _inAppNotifications = true;
  bool _sameChatNotifications = false;
  bool _taskbarFlashing = true;
  bool _desktopNotifications = true;
  bool _notificationSounds = true;
  bool _globalNotifications = false;

  ThemeMode _themeMode = ThemeMode.dark;
  Color _color = Colors.blue;

  PreferenceProvider() {
    _loadPreferences();
  }

  ThemeMode get themeMode => _themeMode;
  Color get color => _color;
  bool get taskbarFlashing => _taskbarFlashing;
  bool get desktopNotifications => _desktopNotifications;
  bool get recieveNotifications => _recieveNotifications;
  bool get inAppNotifications => _inAppNotifications;
  bool get sameChatNotifications => _sameChatNotifications;
  bool get notificationSounds => _notificationSounds;
  bool get globalNotifications => _globalNotifications;

  void toggleThemeMode() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _savePreferences();
    notifyListeners();
  }

  void setTaskbarFlashing(bool taskbarFlashing) {
    _taskbarFlashing = taskbarFlashing;
    _savePreferences();
    notifyListeners();
  }

  void setDesktopNotifications(bool desktopNotifications) {
    _desktopNotifications = desktopNotifications;
    _savePreferences();
    notifyListeners();
  }

  void setRecieveNotifications(bool recieveNotifications) {
    _recieveNotifications = recieveNotifications;
    _savePreferences();
    notifyListeners();
  }

  void setInAppNotifications(bool inAppNotifications) {
    _inAppNotifications = inAppNotifications;
    _savePreferences();
    notifyListeners();
  }

  void setSameChatNotifications(bool sameChatNotifications) {
    _sameChatNotifications = sameChatNotifications;
    _savePreferences();
    notifyListeners();
  }

  void setNotificationSounds(bool notificationSounds) {
    _notificationSounds = notificationSounds;
    _savePreferences();
    notifyListeners();
  }

  void setGlobalNotifications(bool globalNotifications) {
    _globalNotifications = globalNotifications;
    _savePreferences();
    notifyListeners();
  }

  void setSelectedColor(Color color) {
    _color = color;
    _savePreferences();
    notifyListeners();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('themeMode');
    final colorString = prefs.getString('themeColor');

    _taskbarFlashing = prefs.getBool('taskbarFlashing') ?? _taskbarFlashing;
    _desktopNotifications =
        prefs.getBool('desktopNotifications') ?? _desktopNotifications;
    _recieveNotifications =
        prefs.getBool('recieveNotifications') ?? _recieveNotifications;
    _inAppNotifications =
        prefs.getBool('inAppNotifications') ?? _inAppNotifications;
    _sameChatNotifications =
        prefs.getBool('sameChatNotifications') ?? _sameChatNotifications;
    _notificationSounds =
        prefs.getBool('notificationSounds') ?? _notificationSounds;
    _globalNotifications =
        prefs.getBool('globalNotifications') ?? _globalNotifications;

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

    prefs.setBool('taskbarFlashing', _taskbarFlashing);
    prefs.setBool('desktopNotifications', _desktopNotifications);
    prefs.setBool('recieveNotifications', _recieveNotifications);
    prefs.setBool('inAppNotifications', _inAppNotifications);
    prefs.setBool('sameChatNotifications', _sameChatNotifications);
    prefs.setBool('notificationSounds', _notificationSounds);
    prefs.setBool('globalNotifications', _globalNotifications);
  }
}
