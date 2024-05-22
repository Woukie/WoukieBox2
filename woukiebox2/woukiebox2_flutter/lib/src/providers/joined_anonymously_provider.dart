import 'package:flutter/material.dart';

class JoinedAnonymouslyProvider extends ChangeNotifier {
  bool _joined = false;

  bool get joined => _joined;

  void setJoined(bool value) {
    _joined = value;
    notifyListeners();
  }
}
