import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:woukiebox2_flutter/main.dart';

class ConnectionStateProvider extends ChangeNotifier {
  ConnectionState _state = ConnectionState.none;
  final HashMap<int, User> _users = HashMap<int, User>();
  final List<ChatMessage> _messages = List.empty(growable: true);

  ConnectionState get state => _state;
  HashMap<int, User> get users => _users;
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
    await client.closeStreamingConnection();
    _messages.clear();
    _users.clear();
    _state = ConnectionState.none;
    notifyListeners();
  }

  void _handleMessage(SerializableEntity message) {
    print(message);

    if (message is ChatMessage) {
      _messages.add(message);
      notifyListeners();
    } else if (message is RoomMembers) {
      _users.forEach((id, user) {
        user.visible = false;
      });

      for (User user in message.users) {
        _users[user.id] = user;
      }

      notifyListeners();
    } else if (message is LeaveMessage) {
      _users[message.id]?.visible = false;
      notifyListeners();
    } else if (message is JoinMessage) {
      _users[message.user.id] = message.user;
      notifyListeners();
    }
  }
}
