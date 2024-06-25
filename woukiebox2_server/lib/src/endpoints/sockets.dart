import 'dart:core';

import 'package:woukiebox2_server/src/generated/protocol.dart';
import 'package:woukiebox2_server/src/socket/session_manager.dart';
import 'package:woukiebox2_server/src/socket/user_actions.dart';
import 'package:serverpod/serverpod.dart';

class SocketsEndpoint extends Endpoint {
  @override
  Future<void> streamOpened(StreamingSession session) async {
    SessionManager.openConnection(session, setUserObject, sendStreamMessage);
  }

  // Remove the disconnecting user from the users list and broadcast to others that they have left
  @override
  Future<void> streamClosed(StreamingSession session) async {
    SessionManager.closeConnection(session, getUserObject(session).id);
  }

  // Called when a message is recieved from the client, clients can basically just send chat messages and change their profile. All other events like join/leave messages are handled elsewhere
  @override
  Future<void> handleStreamMessage(
    StreamingSession session,
    SerializableEntity message,
  ) async {
    if (message is NetworkChatMessage) {
      switch (message.action) {
        case MessageType.Message:
          UserActions.chatMessage(session, message, getUserObject(session).id);
          break;
        case MessageType.Kick:
          UserActions.kickUser(session, message);
          break;
        case MessageType.Leave:
          UserActions.leaveChat(session, message);
          break;
        case MessageType.Promote:
          UserActions.promoteChatMember(session, message);
          break;
        case MessageType.Rename:
          UserActions.renameChat(session, message);
          break;
        default:
      }
    } else if (message is UpdateProfileClient) {
      UserActions.updateProfile(session, message, getUserObject(session).id);
    } else if (message is FriendRequestClient) {
      UserActions.friendRequest(session, message);
    } else if (message is CreateChatClient) {
      UserActions.createChat(session, message);
    } else if (message is ReadChatClient) {
      UserActions.readChat(session, message);
    }
  }
}
