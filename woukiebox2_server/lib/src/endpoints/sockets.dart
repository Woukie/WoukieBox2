import 'dart:core';

import 'package:woukiebox2_server/src/generated/protocol.dart';
import 'package:woukiebox2_server/src/socket/chat_manager.dart';
import 'package:woukiebox2_server/src/socket/friend_manager.dart';
import 'package:woukiebox2_server/src/socket/session_manager.dart';
import 'package:woukiebox2_server/src/socket/profile_manager.dart';
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
          if (message.message == null) return;
          ChatManager.sendMessage(
            session: session,
            message: message.message!,
            chatId: message.chat,
            senderId: getUserObject(session).id,
          );
          break;
        case MessageType.Rename:
          if (message.message == null) return;
          ChatManager.renameChat(
            session: session,
            name: message.message!,
            chatId: message.chat,
            senderId: getUserObject(session).id,
          );
          break;
        case MessageType.Kick:
          if (message.targets == null || message.targets!.isEmpty) return;
          ChatManager.kickUser(
            session: session,
            chatId: message.chat,
            targetId: message.targets!.first,
            senderId: getUserObject(session).id,
          );
          break;
        case MessageType.Leave:
          ChatManager.leaveChat(
            session: session,
            chatId: message.chat,
            senderId: getUserObject(session).id,
          );
          break;
        case MessageType.Promote:
          ChatManager.promoteUser(
            session: session,
            chatId: message.chat,
            targetId: message.targets!.first,
            senderId: getUserObject(session).id,
          );
          break;
        case MessageType.AddFriends:
          if (message.targets == null || message.targets!.isEmpty) return;
          ChatManager.addFriends(
            session: session,
            chatId: message.chat,
            targetIds: message.targets!,
            senderId: getUserObject(session).id,
          );
          break;
        case MessageType.Create:
          if (message.message == null || message.targets == null) return;
          ChatManager.createChat(
            session: session,
            name: message.message!,
            senderId: getUserObject(session).id,
            targetIds: message.targets!,
          );
          break;
        default:
      }
    } else if (message is UpdateProfileClient) {
      ProfileManager.updateProfile(session, message, getUserObject(session).id);
    } else if (message is FriendRequestClient) {
      FriendManager.friendRequest(
        session: session,
        positive: message.positive,
        targetId: message.target,
      );
    } else if (message is ReadChatClient) {
      ChatManager.readChat(
        session: session,
        chat: message.chat,
      );
    }
  }
}
