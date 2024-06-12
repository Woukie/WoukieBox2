import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StylingProvider extends ChangeNotifier {
  double _cardMargin = 6;

  double get cardMargin => _cardMargin;

  StylingProvider() {
    _loadPreferences();
  }

  void updateCardPadding(double padding) {
    _cardMargin = padding;
    _savePreferences();
    notifyListeners();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final cardMarginString = prefs.getString('cardMargin');

    if (cardMarginString != null) {
      _cardMargin = double.parse(cardMarginString);
    }

    notifyListeners();
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cardMargin', _cardMargin.toString());
  }
}
