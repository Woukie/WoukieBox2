import 'dart:core';

import 'package:serverpod_auth_server/module.dart';
import 'package:woukiebox2_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:woukiebox2_server/src/socket/chat_manager.dart';
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

  // Get a whole bucket of chat messages by the chat id and bucket. If no bucket is specified, the latest will be returned.
  Future<List<NetworkChatMessage>?> getBucket(
      Session session, int chat, int? bucket) async {
    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return null;

    UserPersistent senderPersistant =
        (await Util.getPersistentData(session, senderInfo.id))!;
    if (!senderPersistant.chats.contains(chat)) return null;

    bucket ??= (await ChatManager.getLatestBucket(session, chat)).bucket;

    List<ChatMessage> databaseMessages = await ChatMessage.db.find(
      session,
      where: (t) => (t.chatId.equals(chat)) & (t.bucket.equals(bucket)),
      orderBy: (t) => t.sentAt,
      orderDescending: true,
    );

    return databaseMessages
        .map(
          (databaseMessage) => NetworkChatMessage(
            action: databaseMessage.action,
            sender: senderInfo.id!,
            chat: chat,
            bucket: bucket,
            message: databaseMessage.message,
            sentAt: databaseMessage.sentAt,
            targets: databaseMessage.targets,
          ),
        )
        .toList();
  }
}
