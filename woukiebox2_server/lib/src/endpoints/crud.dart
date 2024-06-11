import 'dart:core';

import 'package:serverpod_auth_server/module.dart';
import 'package:woukiebox2_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:woukiebox2_server/src/util.dart';

class CrudEndpoint extends Endpoint {
  // Get user data for a specific user. Works even when the user is offline
  Future<UserServer?> getUser(Session session, int targetId) async {
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

    return UserServer(
      id: targetId,
      username: targetInfo.userName,
      bio: targetPersistant.bio,
      colour: targetPersistant.color,
      image: imageUri.toString(),
      verified: true,
    );
  }
}
