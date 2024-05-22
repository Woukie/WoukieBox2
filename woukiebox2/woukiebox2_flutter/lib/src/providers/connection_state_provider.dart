import 'dart:async';

import 'package:flutter/material.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:woukiebox2_flutter/main.dart';

class ConnectionStateProvider extends ChangeNotifier {
  ConnectionState _state = ConnectionState.none;
  final List<User> _users = List.empty(growable: true);
  final List<ChatMessage> _messages = List.empty(growable: true);

  ConnectionState get state => _state;
  List<User> get users => _users;
  List<ChatMessage> get messages => _messages;

  StreamSubscription? _streamSubscription;

  void openConnection() async {
    _state = ConnectionState.waiting;
    notifyListeners();
    try {
      await client.openStreamingConnection();

      _state = ConnectionState.active;

      _streamSubscription ??= client.sockets.stream.listen(_handleMessage);
    } catch (error) {
      _state = ConnectionState.none;
    }
    notifyListeners();
  }

  Future<void> closeConnection() async {
    // await _streamSubscription!.cancel();
    await client.closeStreamingConnection();
    _messages.clear();
    _users.clear();
    _state = ConnectionState.none;
    notifyListeners();
  }

  void _handleMessage(SerializableEntity message) {
    if (message is ChatMessage) {
      _messages.add(message);
      notifyListeners();
    }
  }
}
