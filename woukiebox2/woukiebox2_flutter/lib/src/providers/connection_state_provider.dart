import 'package:flutter/material.dart';
import 'package:woukiebox2_flutter/main.dart';

class ConnectionStateProvider extends ChangeNotifier {
  ConnectionState _state = ConnectionState.none;

  ConnectionState get state => _state;

  void openConnection() async {
    _state = ConnectionState.waiting;
    notifyListeners();
    try {
      await client.openStreamingConnection();
      _state = ConnectionState.active;
    } catch (error) {
      _state = ConnectionState.none;
    }
    notifyListeners();
  }

  Future<void> closeConnection() async {
    _state = ConnectionState.none;
    notifyListeners();
    await client.closeStreamingConnection();
  }
}
