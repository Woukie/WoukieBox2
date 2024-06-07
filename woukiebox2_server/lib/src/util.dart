import 'dart:math';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';
import 'package:woukiebox2_server/src/generated/protocol.dart';

// Don't know how to have internal functions on an endpoint without also exposing them to the client. So this class handles a random assortment of things.
class Util {
  static Future<UserInfo?> getAuthUser(Session session, [int? id]) async {
    int? senderId = id ?? await session.auth.authenticatedUserId;
    if (senderId == null) return null;

    UserInfo? senderInfo = await Users.findUserByUserId(session, senderId);
    return senderInfo;
  }

  // Get the persistant data of the user with the specified id.
  // Creates data if not already present.
  // If no id is specified session must be authenticated.
  // Only returns null when session is not authenticated and no id is specified.
  static Future<UserPersistent?> getPersistentData(
    Session session, [
    int? id,
  ]) async {
    id ??= await session.auth.authenticatedUserId;
    if (id == null) return null;

    UserPersistent? extraUserData = await UserPersistent.db.findFirstRow(
      session,
      where: (record) => record.userInfoId.equals(id),
    );

    extraUserData ??= await UserPersistent.db.insertRow(
      session,
      UserPersistent(
        userInfoId: id,
        color: randomColour(),
        image: "",
        bio: "",
        friends: List<int>.empty(),
        outgoingFriendRequests: List<int>.empty(),
        incomingFriendRequests: List<int>.empty(),
      ),
    );

    return extraUserData;
  }

  // Sets and returns the user object and updates connectedUsers. User constructed with database values if authenticated
  static Future<User?> initUser(
    StreamingSession session,
    Set<User> connectedUsers,
    Function(Session, dynamic) setUserObject,
  ) async {
    UserInfo? senderInfo = await Util.getAuthUser(session);

    if (senderInfo != null) {
      if (connectedUsers.any((user) => user.id == senderInfo.id)) return null;
      UserPersistent senderPersistant =
          (await Util.getPersistentData(session))!;

      Uri? imageUri = await session.storage.getPublicUrl(
        storageId: 'public',
        path: senderPersistant.image,
      );

      User user = User(
        id: senderInfo.id!,
        colour: senderPersistant.color,
        username: senderInfo.userName,
        image: imageUri.toString(),
        bio: senderPersistant.bio,
        verified: true,
        visible: true,
      );

      connectedUsers.add(user);
      setUserObject(session, (id: user.id));

      print("Authenticated user joined!");

      return user;
    }

    User user = User(
      id: Random().nextInt(100000000),
      colour: Util.randomColour(),
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

  static String randomColour() {
    double r = Random().nextDouble();
    double g = Random().nextDouble();
    double b = Random().nextDouble();

    final double magnitude = sqrt(r * r + g * g + b * b);

    r = r.abs() / magnitude;
    g = g.abs() / magnitude;
    b = b.abs() / magnitude;

    r *= 256;
    g *= 256;
    b *= 256;

    String color = 'FF${r.floor().toRadixString(16).padLeft(2, '0')}'
        '${g.floor().toRadixString(16).padLeft(2, '0')}'
        '${b.floor().toRadixString(16).padLeft(2, '0')}';

    print(color);

    return color;
  }
}