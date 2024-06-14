import 'dart:collection';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';
import 'package:woukiebox2_server/src/generated/protocol.dart';
import 'package:woukiebox2_server/src/util.dart';

class BucketData {
  int count;
  int bucket;

  BucketData(this.count, this.bucket);
}

class ChatMessageManager {
  static final HashMap<int, BucketData> _latestBucket =
      HashMap<int, BucketData>();

  static Future<int> _getLatestBucket(Session session, int target) async {
    if (_latestBucket.containsKey(target)) return _latestBucket[target]!.bucket;

    var bucketMessages = await ChatMessage.db.find(
      session,
      where: (t) => t.chatId.equals(target),
      orderBy: (t) => t.bucket,
    );

    _latestBucket[target] =
        BucketData(bucketMessages.length, bucketMessages.first.bucket);

    return _latestBucket[target]!.bucket;
  }

  // Must be authed, hence no userId required
  static sendChatMessage(Session session, ChatMessageClient message) async {
    String trimmedMessage = message.message.trim();
    if (trimmedMessage.isEmpty) return;

    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return;

    Chat? groupChat = await Chat.db.findById(session, message.target);
    if (groupChat == null) return;

    if (!groupChat.users.contains(senderInfo.id!)) return;

    ChatMessage databaseMessage = ChatMessage(
      sentAt: DateTime.now(),
      chatId: message.target,
      message: trimmedMessage,
      senderId: senderInfo.id!,
      bucket: await _getLatestBucket(session, message.target),
    );

    await ChatMessage.db.insertRow(session, databaseMessage);
    for (int user in groupChat.users) {
      session.messages.postMessage(
        user.toString(),
        ChatMessageServer(
            sender: senderInfo.id!,
            chat: message.target,
            message: message.message),
      );
    }
  }

  static sendGlobalMessage(
    Session session,
    ChatMessageClient message,
    int userId,
  ) {
    String trimmedMessage = message.message.trim();
    if (trimmedMessage.isEmpty) return;

    ChatMessageServer chatMessage = ChatMessageServer(
      sender: userId,
      chat: message.target,
      message: trimmedMessage,
    );

    session.messages.postMessage(
      'global',
      chatMessage,
    );
  }
}
