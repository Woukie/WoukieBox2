import 'dart:math';
import 'dart:core';

import 'package:serverpod_auth_server/module.dart';
import 'package:woukiebox2_server/src/generated/protocol.dart';
import 'package:woukiebox2_server/src/socket_messages.dart';
import 'package:woukiebox2_server/src/util.dart';
import 'package:serverpod/serverpod.dart';

class SocketsEndpoint extends Endpoint {
  // setUserData is basically fucking useless because you can't get a list of all active sessions. We now have to manually keep track of users while STILL having to use userData to store the session id's
  static Set<UserServer> connectedUsers = {};
  final Random random = Random();

  @override
  Future<void> streamOpened(StreamingSession session) async {
    UserServer? user = await Util.initUser(session, setUserObject);

    if (user == null) return; // Prevent joining with the same ID twice

    // Register the session with the global channel
    session.messages.addListener('global', (message) {
      sendStreamMessage(session, message);
    });

    // Register the session with their own channel (i.e. dms and friend requests)
    session.messages.addListener(user.id.toString(), (message) {
      sendStreamMessage(session, message);
    });

    // Send the client a list of all the members in the room
    sendStreamMessage(
      session,
      RoomMembersServer(
        users: connectedUsers.toList(),
      ),
    );

    // Give the client their ID so they know which user they are
    sendStreamMessage(session, SelfIdentifierServer(id: user.id));

    // Broadcast to everyone that a new person has entered the global chat
    session.messages.postMessage(
      "global",
      JoinChatServer(
        sender: user,
        chat: 0,
      ),
    );

    UserInfo? senderInfo = await Util.getAuthUser(session);

    // Give them their friend list and chat rooms
    if (senderInfo != null) {
      UserPersistent userPersistent = (await Util.getPersistentData(session))!;

      List<Chat> chats = List.empty(growable: true);
      for (int chatId in userPersistent.chats) {
        Chat? chat = await Chat.db.findById(session, chatId);
        if (chat != null) chats.add(chat);
      }

      sendStreamMessage(
        session,
        ChatsServer(
          chats: chats,
        ),
      );

      sendStreamMessage(
        session,
        FriendListServer(
          friends: userPersistent.friends,
          incomingFriendRequests: userPersistent.incomingFriendRequests,
          outgoingFriendRequests: userPersistent.outgoingFriendRequests,
        ),
      );
    }
  }

  // Remove the disconnecting user from the users list and broadcast to others that they have left
  @override
  Future<void> streamClosed(StreamingSession session) async {
    int id = getUserObject(session).id;
    connectedUsers.removeWhere((user) => user.id == id);

    session.messages.postMessage(
      "global",
      LeaveChatServer(chat: 0, sender: id),
    );

    print("User left!");
  }

  // Called when a message is recieved from the client, clients can basically just send chat messages and change their profile. All other events like join/leave messages are handled elsewhere
  @override
  Future<void> handleStreamMessage(
    StreamingSession session,
    SerializableEntity message,
  ) async {
    print("Recieved stream message from a client!");
    print(message);

    // Believe it or not, a switch/case would be worse.
    if (message is ChatMessageClient) {
      HandleSocketMessage.chatMessage(
        session,
        message,
        getUserObject,
      );
    } else if (message is UpdateProfileClient) {
      HandleSocketMessage.updateProfile(
        session,
        message,
        getUserObject,
      );
    } else if (message is FriendRequestClient) {
      HandleSocketMessage.friendRequest(session, message);
    } else if (message is CreateChatClient) {
      HandleSocketMessage.createChat(session, message);
    } else if (message is LeaveChatClient) {
      HandleSocketMessage.leaveChat(session, message);
    } else if (message is RenameChat) {
      HandleSocketMessage.renameChat(session, message);
    }
  }
}
