import 'dart:math';
import 'dart:core';

import 'package:serverpod_auth_server/module.dart';
import 'package:woukiebox2_server/src/endpoints/sockets.dart';
import 'package:woukiebox2_server/src/generated/protocol.dart';
import 'package:woukiebox2_server/src/util.dart';
import 'package:serverpod/serverpod.dart';

class ProfilePictureEndpoint extends Endpoint {
  final Random random = Random();

  // Profile image uploading. Can't use default as I need control over the naming scheme
  Future<String?> getUploadDescription(Session session) async {
    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return null;

    UserPersistent extraUserData =
        (await Util.getPersistentData(session, senderInfo.id))!;

    String filePath = "${senderInfo.id}_${random.nextInt(100000000)}";

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
    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return false;

    UserPersistent senderPersistant =
        (await Util.getPersistentData(session, senderInfo.id))!;

    var successful = await session.storage.verifyDirectFileUpload(
      storageId: 'public',
      path: senderPersistant.image,
    );

    Uri? imageUri = await session.storage.getPublicUrl(
      storageId: 'public',
      path: senderPersistant.image,
    );

    // Update everyone with image change
    if (successful) {
      session.messages.postMessage(
        'global',
        UpdateProfile(
          sender: senderInfo.id,
          image: imageUri.toString(),
        ),
      );

      SocketsEndpoint.connectedUsers
          .firstWhere((user) => user.id == senderInfo.id)
          .image = imageUri.toString();
    }

    return successful;
  }
}
