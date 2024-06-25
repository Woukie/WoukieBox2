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

class ChatManager {
  static final HashMap<int, BucketData> _latestBucket =
      HashMap<int, BucketData>();

  static final int bucketSize = 100;

  static void deleteBucket(int target) {
    _latestBucket.remove(target);
  }

  static Future<BucketData> getLatestBucket(Session session, int target) async {
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
    BucketData bucket = await getLatestBucket(session, target);

    bucket.count += 1;

    if (bucket.count >= bucketSize) {
      bucket.count = 0;
      bucket.bucket += 1;
    }
  }

  static Future<void> sendMessage({
    required StreamingSession session,
    required String message,
    required int chatId,
    required int senderId,
  }) async {
    String trimmedMessage = message.trim();
    if (trimmedMessage.isEmpty) return;

    DateTime now = DateTime.now().toUtc();

    if (chatId == 0) {
      session.messages.postMessage(
        'global',
        NetworkChatMessage(
          action: MessageType.Message,
          sentAt: now,
          sender: senderId,
          chat: chatId,
          message: trimmedMessage,
        ),
      );

      return;
    }

    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return;

    Chat? groupChat = await Chat.db.findById(session, chatId);
    if (groupChat == null) return;

    if (!groupChat.users.contains(senderInfo.id!)) return;

    ChatMessage writtenMessage = await _writeMessageToDatabase(
      action: MessageType.Message,
      session: session,
      senderId: senderId,
      chatId: chatId,
      sentAt: now,
      message: null,
    );

    for (int user in groupChat.users) {
      session.messages.postMessage(
        user.toString(),
        NetworkChatMessage(
          action: writtenMessage.action,
          sender: writtenMessage.senderId,
          chat: writtenMessage.chatId,
          sentAt: writtenMessage.sentAt,
          message: writtenMessage.message!,
          bucket: writtenMessage.bucket,
        ),
      );
    }
  }

  static void kickUser({
    required StreamingSession session,
    required int chat,
    required int target,
    required int sender,
  }) {}

  static void leaveChat({
    required StreamingSession session,
    required int chat,
    required int sender,
  }) {}

  static void promoteUser({
    required StreamingSession session,
    required int chat,
    required int target,
    required int sender,
  }) {}

  static void addFriends({
    required StreamingSession session,
    required int chat,
    required List<int> targets,
    required int sender,
  }) {}

  static void renameChat({
    required StreamingSession session,
    required String name,
    required int chat,
    required int sender,
  }) {}

  static Future<ChatMessage> _writeMessageToDatabase({
    required Session session,
    required MessageType action,
    required int senderId,
    required int chatId,
    required DateTime sentAt,
    required String? message,
  }) async {
    BucketData latestBucket = await getLatestBucket(session, chatId);
    ChatMessage databaseMessage = ChatMessage(
      action: MessageType.Message,
      sentAt: sentAt,
      message: message,
      bucket: latestBucket.bucket,
      senderId: senderId,
      chatId: chatId,
    );

    await ChatMessage.db.insertRow(session, databaseMessage);

    _incrementBucket(session, chatId);

    return databaseMessage;
  }
}
