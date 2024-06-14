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

  static final int bucketSize = 10;

  static void deleteBucket(int target) {
    _latestBucket.remove(target);
  }

  static Future<BucketData> _getLatestBucket(
      Session session, int target) async {
    if (_latestBucket.containsKey(target)) return _latestBucket[target]!;

    var bucketMessages = await ChatMessage.db.find(
      session,
      where: (t) => t.chatId.equals(target),
      orderBy: (t) => t.bucket,
      orderDescending: true,
    );

    if (bucketMessages.isEmpty) {
      _latestBucket[target] = BucketData(0, 1);
    } else {
      int bucket = bucketMessages.first.bucket;

      _latestBucket[target] = BucketData(
        bucketMessages.where((message) => message.bucket == bucket).length,
        bucketMessages.first.bucket,
      );
    }

    return _latestBucket[target]!;
  }

  static _incrementBucket(Session session, int target) async {
    BucketData bucket = await _getLatestBucket(session, target);

    bucket.count += 1;

    if (bucket.count >= bucketSize) {
      bucket.count = 0;
      bucket.bucket += 1;
    }
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

    BucketData latestBucket = await _getLatestBucket(session, message.target);
    ChatMessage databaseMessage = ChatMessage(
      sentAt: DateTime.now(),
      chatId: message.target,
      message: trimmedMessage,
      senderId: senderInfo.id!,
      bucket: latestBucket.bucket,
    );

    await ChatMessage.db.insertRow(session, databaseMessage);

    _incrementBucket(session, message.target);

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
