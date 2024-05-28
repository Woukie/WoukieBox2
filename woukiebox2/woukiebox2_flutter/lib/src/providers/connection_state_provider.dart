import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:woukiebox2_flutter/main.dart';
import 'package:woukiebox2_flutter/src/util/written_message.dart';

class ConnectionStateProvider extends ChangeNotifier {
  late final StreamingConnectionHandler _connectionHandler;

  final HashMap<int, User> _users = HashMap<int, User>();
  final List<dynamic> _messages = List.empty(growable: true);
  int? _currentUser;

  StreamingConnectionHandler get connectionHandler => _connectionHandler;
  HashMap<int, User> get users => _users;
  List<dynamic> get messages => _messages;
  int? get currentUser => _currentUser;

  StreamSubscription? _streamSubscription;

  ConnectionStateProvider() {
    _connectionHandler = StreamingConnectionHandler(
      client: client,
      listener: _handleStatus,
    );
  }

  void openConnection() async {
    _connectionHandler.connect();

    _streamSubscription ??= client.sockets.stream.listen(_handleMessage);

    notifyListeners();
  }

  Future<void> closeConnection() async {
    _connectionHandler.close();
    _messages.clear();
    _users.clear();
    notifyListeners();
  }

  // Get latest state with _connectionHandler.status
  void _handleStatus(StreamingConnectionHandlerState message) {
    notifyListeners();
  }

  void _handleMessage(SerializableEntity message) {
    if (message is ChatMessage) {
      User? user = _users[message.sender];
      if (user == null) return; // This will never happen. But who knows?

      // We do this to preserve the details at the time of the message. If we only have a reference to the user.id, then sender and color would update
      _messages.add(
        WrittenMessage(
          user.id,
          user.username,
          message.message,
          user.colour,
        ),
      );
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

      _messages.add(
        WrittenLeaveMessage(
          message.id,
          user.username,
          user.colour,
        ),
      );

      _users[message.id]?.visible = false;
      notifyListeners();
    } else if (message is JoinMessage) {
      _messages.add(
        WrittenJoinMessage(
          message.user.id,
          message.user.username,
          message.user.colour,
        ),
      );

      _users[message.user.id] = message.user;
      notifyListeners();
    } else if (message is SelfIdentifier) {
      _currentUser = message.id;
      notifyListeners();
    } else if (message is UpdateProfile) {
      User? user = _users[message.sender];
      // The server never sends a null sender, and all users are tracked. But who knows?
      if (user == null) return;

      // We only want to print name and colour changes to the chat
      if (message.username != null || message.colour != null) {
        _messages.add(
          WrittenProfileMessage(
            message.sender!,
            user.username,
            user.colour,
            message.username,
            message.colour,
          ),
        );
      }

      print(message.image);

      _users.update(
        message.sender!, // We know there's a user with this id
        (user) => user.copyWith(
          bio: message.bio,
          colour: message.colour,
          username: message.username,
          image: message.image,
        ),
      );

      notifyListeners();
    }
  }
}
