import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:woukiebox2_flutter/main.dart';
import 'package:woukiebox2_flutter/src/util/hex_color.dart';

class ConnectionStateProvider extends ChangeNotifier {
  ConnectionState _state = ConnectionState.none;
  final HashMap<int, User> _users = HashMap<int, User>();
  final List<dynamic> _messages = List.empty(growable: true);
  int? _currentUser;

  ConnectionState get state => _state;
  HashMap<int, User> get users => _users;
  List<dynamic> get messages => _messages;
  int? get currentUser => _currentUser;

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
      User? user = _users[message.id];
      if (user == null) return; // This will never happen. But who knows?

      _messages.add("${user.username} left the chat");
      _users[message.id]?.visible = false;
      notifyListeners();
    } else if (message is JoinMessage) {
      _messages.add(TextSpan(
        children: [
          TextSpan(
            text: message.user.username,
            style: TextStyle(
              color: HexColor.fromHex(message.user.colour),
            ),
          ),
          const TextSpan(
            text: " joined the chat",
          ),
        ],
      ));
      _users[message.user.id] = message.user;
      notifyListeners();
    } else if (message is SelfIdentifier) {
      _currentUser = message.id;
      notifyListeners();
    } else if (message is UpdateProfile) {
      User? user = _users[message.sender];
      // The server never sends a null sender, and all users are tracked. But who knows?
      if (user == null) return;

      _users.update(
        message.sender!, // We know there's a user with this id
        (user) => user.copyWith(
          bio: message.bio,
          colour: message.colour,
          username: message.username,
        ),
      );

      notifyListeners();
    }
  }
}
