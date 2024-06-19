import 'dart:math';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';
import 'package:woukiebox2_server/src/generated/protocol.dart';
import 'package:woukiebox2_server/src/util.dart';

class SessionManager {
  // setUserData is basically useless because you can't get a list of all active sessions. We now have to manually keep track of users while STILL having to use userData to store the session ids
  static Set<UserServer> connectedUsers = {};

  static closeConnection(Session session, int userId) {
    connectedUsers.removeWhere((user) => user.id == userId);

    session.messages.postMessage(
      "global",
      LeaveChatServer(
        chat: 0,
        sender: userId,
        sentAt: DateTime.now().toUtc(),
      ),
    );

    print("User left!");
  }

  static openConnection(
    StreamingSession session,
    Function(Session, dynamic) setUserObject,
    Function(StreamingSession, SerializableEntity) sendStreamMessage,
  ) async {
    UserServer? user = await _initUser(session, setUserObject);
    if (user == null) return;

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
        sentAt: DateTime.now().toUtc(),
      ),
    );

    UserInfo? senderInfo = await Util.getAuthUser(session);

    // Give them their friend list, chat rooms and last viewed data
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

      List<LastRead> lastReadData = await LastRead.db.find(
        session,
        where: (t) => t.userInfoId.equals(senderInfo.id),
      );

      Map<int, DateTime> viewedData = {
        for (var lastRead in lastReadData) lastRead.chatId: lastRead.readAt
      };

      sendStreamMessage(session, LastReadServer(readData: viewedData));
    }
  }

  // Sets and returns the user object and updates connectedUsers. User constructed with database values if authenticated. Returns null if failed
  static Future<UserServer?> _initUser(
    StreamingSession session,
    Function(Session, dynamic) setUserObject,
  ) async {
    UserInfo? senderInfo = await Util.getAuthUser(session);

    if (senderInfo != null) {
      if (connectedUsers.any(
        (user) => user.id == senderInfo.id,
      )) {
        return null;
      }

      UserPersistent senderPersistant =
          (await Util.getPersistentData(session))!;

      Uri? imageUri = await session.storage.getPublicUrl(
        storageId: 'public',
        path: senderPersistant.image,
      );

      UserServer user = UserServer(
        id: senderInfo.id!,
        colour: senderPersistant.color,
        username: senderInfo.userName,
        image: imageUri.toString(),
        bio: senderPersistant.bio,
        verified: true,
      );

      connectedUsers.add(user);
      setUserObject(session, (id: user.id));

      print("Authenticated user joined!");

      return user;
    }

    UserServer user = UserServer(
      id: Random().nextInt(100000000),
      colour: Util.randomColour(),
      username: "Anonymous",
      image: "",
      bio: "",
      verified: false,
    );

    connectedUsers.add(user);
    setUserObject(session, (id: user.id));

    print("Anonymous user joined!");

    return user;
  }
}
