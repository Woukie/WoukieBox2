import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:woukiebox2/src/util/assets.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:woukiebox2/main.dart';
import 'package:woukiebox2/src/util/written_message.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ConnectionStateProvider extends ChangeNotifier {
  late final StreamingConnectionHandler _connectionHandler;

  final _winNotifyPlugin = WindowsNotification(
      applicationId:
          r"{6D809377-6AF0-444B-8957-A3773F02200E}\WoukieBox2\WoukieBox2.exe");

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
    _currentUser = null;
    notifyListeners();
  }

  // Get latest state with _connectionHandler.status
  void _handleStatus(StreamingConnectionHandlerState message) {
    notifyListeners();
  }

  Future<void> _handleMessage(SerializableEntity message) async {
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
          user.image,
        ),
      );

      notifyListeners();
      if (!await windowManager.isFocused()) {
        NotificationMessage notification =
            NotificationMessage.fromPluginTemplate(
          "WoukieBox2",
          user.username,
          message.message,
          image: (user.image == ""
                  ? await getImageFileFromAssets("anonymous-profile.png")
                  : await DefaultCacheManager().getSingleFile(user.image))
              .absolute
              .path,
        );
        _winNotifyPlugin.showNotificationPluginTemplate(notification);
      }
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
