import 'dart:math';

import 'package:serverpod_auth_server/module.dart';
import 'package:woukiebox2_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class SocketsEndpoint extends Endpoint {
  // setUserData is basically fucking useless because you can't get a list of all active sessions. We now have to manually keep track of users while STILL having to use userData to store the session id's
  final Set<User> connectedUsers = {};
  final Random random = Random();

  // Profile image uploading. Can't use default as I need control over the naming scheme
  Future<String?> getUploadDescription(Session session) async {
    if (!await session.isUserSignedIn) {
      throw 'Could not upload image. User not authenticated';
    }

    var userId = await session.auth.authenticatedUserId;
    UserPersistent extraUserData = await getPersistentData(session, userId);

    String filePath = "${userId}_${random.nextInt(100000000)}";

    await session.storage.deleteFile(
      storageId: 'public',
      path: extraUserData.image,
    );

    final uploadDescription =
        await session.storage.createDirectFileUploadDescription(
      storageId: 'public',
      path: filePath,
    );

    extraUserData.image = filePath;
    await UserPersistent.db.updateRow(session, extraUserData);

    return uploadDescription;
  }

  Future<bool> verifyUpload(Session session) async {
    if (!await session.isUserSignedIn) {
      throw 'Could not verify upload. User not authenticated';
    }

    var userId = await session.auth.authenticatedUserId;
    UserPersistent extraUserData = await getPersistentData(session, userId);

    var successful = await session.storage.verifyDirectFileUpload(
      storageId: 'public',
      path: extraUserData.image,
    );

    Uri? imageUri = await session.storage.getPublicUrl(
      storageId: 'public',
      path: extraUserData.image,
    );

    // Update everyone with image change
    if (successful) {
      session.messages.postMessage(
        'global',
        UpdateProfile(
          sender: userId,
          image: imageUri.toString(),
        ),
      );
    }

    return successful;
  }

  // Sockets
  Future<UserPersistent> getPersistentData(session, userId) async {
    UserPersistent? extraUserData = await UserPersistent.db.findFirstRow(
      session,
      where: (record) => record.userInfoId.equals(userId),
    );

    extraUserData ??= await UserPersistent.db.insertRow(
      session,
      UserPersistent(
        userInfoId: userId,
        color: ((random.nextDouble() * 0.5 + 0.5) * 0xFFFFFF).toString(),
        image: "",
        bio: "",
      ),
    );

    return extraUserData;
  }

  // Sets and returns the user object and updates connectedUsers. User constructed with database values if authenticated
  Future<User?> initUser(StreamingSession session) async {
    if (await session.isUserSignedIn) {
      var userId = await session.auth.authenticatedUserId;

      if (connectedUsers.any((user) => user.id == userId)) return null;

      var userInfo = await Users.findUserByUserId(session, userId!);

      if (userInfo != null) {
        UserPersistent extraUserData = await getPersistentData(session, userId);

        Uri? imageUri = await session.storage.getPublicUrl(
          storageId: 'public',
          path: extraUserData.image,
        );

        User user = User(
          id: userId,
          colour: extraUserData.color,
          username: userInfo.userName,
          image: imageUri.toString(),
          bio: extraUserData.bio,
          verified: true,
          visible: true,
        );

        connectedUsers.add(user);
        setUserObject(session, (id: user.id));

        print("Authenticated user joined!");

        return user;
      }
    }

    User user = User(
      id: 1111000000000 + random.nextInt(100000000),
      colour: ((random.nextDouble() * 0.5 + 0.5) * 0xFFFFFF).toString(),
      username: "Anonymous",
      image: "",
      bio: "",
      verified: false,
      visible: true,
    );

    connectedUsers.add(user);
    setUserObject(session, (id: user.id));

    print("Anonymous user joined!");

    return user;
  }

  @override
  Future<void> streamOpened(StreamingSession session) async {
    User? user = await initUser(session);

    if (user == null) return; // Prevent joining with the same ID twice

    // Register the session with the global channel
    session.messages.addListener('global', (message) {
      sendStreamMessage(session, message);
    });

    // Send the client a list of all the members in the room
    sendStreamMessage(session, RoomMembers(users: connectedUsers.toList()));

    // Give the client their ID so they know which user they are
    sendStreamMessage(session, SelfIdentifier(id: user.id));

    // Broadcast to everyone that a new person has entered the room
    session.messages.postMessage("global", JoinMessage(user: user));
  }

  // Remove the disconnecting user from the users list and broadcast to others that they have left
  @override
  Future<void> streamClosed(StreamingSession session) async {
    int id = getUserObject(session).id;
    connectedUsers.removeWhere((user) => user.id == id);

    session.messages.postMessage("global", LeaveMessage(id: id));

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

    if (message is ChatMessage) {
      session.messages.postMessage(
        'global',
        ChatMessage(
          sender: getUserObject(session).id,
          message: message.message,
        ),
      );
    } else if (message is UpdateProfile) {
      // Update the users profile on the database, also note that profile pics are neither cached or updated in UpdateProfile.
      var userId = await session.auth.authenticatedUserId;
      if (userId != null) {
        UserPersistent extraUserData = await getPersistentData(session, userId);

        extraUserData.bio = message.bio ?? extraUserData.bio;
        extraUserData.color = message.colour ?? extraUserData.color;

        await UserPersistent.db.updateRow(session, extraUserData);

        if (message.username != null) {
          Users.changeUserName(session, userId, message.username!);
        }
      }

      var unauthedID = getUserObject(session).id;
      // Also update the cached user as some users are anonymous
      User user = connectedUsers.firstWhere((user) => user.id == unauthedID);
      user.bio = message.bio ?? user.bio;
      user.username = message.username ?? user.username;
      user.colour = message.colour ?? user.colour;

      // Tell everyone about the profile change
      session.messages.postMessage(
        'global',
        UpdateProfile(
          sender: unauthedID,
          username: message.username,
          bio: message.bio,
          colour: message.colour,
        ),
      );
    }
  }
}
