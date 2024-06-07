import 'dart:core';

import 'package:serverpod_auth_server/module.dart';
import 'package:woukiebox2_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:woukiebox2_server/src/util.dart';

class CrudEndpoint extends Endpoint {
  // Get user data for a specific user. Works even when the user is offline
  Future<User?> getUser(Session session, int targetId) async {
    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return null;

    UserInfo? targetInfo = await Util.getAuthUser(session, targetId);
    if (targetInfo == null) return null;

    UserPersistent targetPersistant =
        (await Util.getPersistentData(session, targetId))!;

    Uri? imageUri = await session.storage.getPublicUrl(
      storageId: 'public',
      path: targetPersistant.image,
    );

    // I REALLY hate how I can't modify the serverpod-provided user model.
    //Seriously annoying having to use UserInfo for auth and username, and UserPersistent for everything else.
    //Not to mention having to use a THIRD one so we can actually send a whole user to the client
    return User(
      id: targetId,
      username: targetInfo.userName,
      bio: targetPersistant.bio,
      colour: targetPersistant.color,
      image: imageUri.toString(),
      verified: true,
    );
  }
}
