import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:woukiebox2/main.dart';

class ConnectionStateProvider extends ChangeNotifier {
  late final AppStateProvider _appStateProvider;

  StreamSubscription? _streamSubscription;

  late final StreamingConnectionHandler _connectionHandler;
  StreamingConnectionHandler get connectionHandler => _connectionHandler;

  ConnectionStateProvider(BuildContext context) {
    _appStateProvider = Provider.of<AppStateProvider>(context, listen: false);

    _connectionHandler = StreamingConnectionHandler(
      client: client,
      listener: _handleStatus,
    );

    if (sessionManager.isSignedIn) {
      openConnection();
    }
  }

  void openConnection() async {
    _connectionHandler.connect();

    _streamSubscription ??= client.sockets.stream.listen(_handleMessage);

    notifyListeners();
  }

  Future<void> closeConnection() async {
    _connectionHandler.close();
    _appStateProvider.resetData();
    sessionManager.signOut();
    notifyListeners();
  }

  // Get latest state with _connectionHandler.status
  void _handleStatus(StreamingConnectionHandlerState message) {
    if (connectionHandler.client.streamingConnectionStatus ==
        StreamingConnectionStatus.disconnected) {
      // It's likely that users+messages will become desynced so we close the connection
      closeConnection();
    }
    notifyListeners();
  }

  Future<void> _handleMessage(SerializableEntity message) async {
    print("${message.runtimeType} | $message");

    if (message is ChatMessageServer) {
      _appStateProvider.chatMessage(message);
    } else if (message is RoomMembersServer) {
      _appStateProvider.roomMembers(message);
    } else if (message is LeaveChatServer) {
      _appStateProvider.leaveMessage(message);
    } else if (message is JoinChatServer) {
      _appStateProvider.joinMessage(message);
    } else if (message is SelfIdentifierServer) {
      _appStateProvider.selfIdentifier(message);
    } else if (message is UpdateProfileServer) {
      _appStateProvider.updateProfile(message);
    } else if (message is ChatsServer) {
      _appStateProvider.initGroupChats(message);
    } else if (message is FriendListServer) {
      _appStateProvider.friendList(message);
    } else if (message is CreateChatServer) {
      _appStateProvider.createChat(message);
    } else if (message is RenameChat) {
      _appStateProvider.renameChat(message);
    }
  }
}
