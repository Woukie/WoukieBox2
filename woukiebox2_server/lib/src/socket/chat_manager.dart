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

  static Future<void> kickUser({
    required StreamingSession session,
    required int chatId,
    required int targetId,
    required int senderId,
  }) async {
    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return;

    UserInfo? targetInfo = await Util.getAuthUser(session);
    if (targetInfo == null) return;

    UserPersistent targetPersistent =
        (await Util.getPersistentData(session, targetId))!;

    Chat? groupChat = await Chat.db.findById(session, chatId);
    if (groupChat == null) return;

    if (!groupChat.owners.contains(senderId)) return;
    if (groupChat.owners.contains(targetId)) return;
    if (!groupChat.users.contains(targetId)) return;

    bool deleted = await _removeUserFromChat(
      session: session,
      userPersistent: targetPersistent,
      userInfo: targetInfo,
      chat: groupChat,
    );

    ChatMessage? chatMessage;
    if (!deleted) {
      chatMessage = await _writeMessageToDatabase(
        session: session,
        action: MessageType.Kick,
        senderId: senderId,
        targets: [targetId],
        chatId: chatId,
        sentAt: DateTime.now().toUtc(),
      );
    }

    groupChat.users.add(targetInfo.id!);
    for (int user in groupChat.users) {
      session.messages.postMessage(
        user.toString(),
        NetworkChatMessage(
          chat: chatId,
          action: MessageType.Kick,
          bucket: chatMessage?.bucket,
          sentAt: chatMessage?.sentAt,
          sender: senderId,
          targets: [targetId],
        ),
      );
    }
  }

  static Future<void> leaveChat({
    required StreamingSession session,
    required int chatId,
    required int senderId,
  }) async {
    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return;

    UserPersistent senderPersistent =
        (await Util.getPersistentData(session, senderInfo.id))!;

    if (!senderPersistent.chats.contains(chatId)) return;

    Chat? chat = await Chat.db.findById(session, chatId);
    if (chat == null) return;

    bool deleted = await _removeUserFromChat(
      session: session,
      userPersistent: senderPersistent,
      userInfo: senderInfo,
      chat: chat,
    );

    ChatMessage? chatMessage;
    if (!deleted) {
      chatMessage = await _writeMessageToDatabase(
        session: session,
        action: MessageType.Leave,
        senderId: senderId,
        chatId: chatId,
        sentAt: DateTime.now().toUtc(),
      );
    }

    chat.users.add(senderInfo.id!);
    for (int user in chat.users) {
      session.messages.postMessage(
        user.toString(),
        NetworkChatMessage(
          action: MessageType.Leave,
          bucket: chatMessage?.bucket,
          sentAt: chatMessage?.sentAt,
          sender: senderId,
          chat: chatId,
        ),
      );
    }
  }

  static void promoteUser({
    required StreamingSession session,
    required int chatId,
    required int targetId,
    required int senderId,
  }) {}

  static void addFriends({
    required StreamingSession session,
    required int chatId,
    required List<int> targetIds,
    required int senderId,
  }) {}

  static void renameChat({
    required StreamingSession session,
    required String name,
    required int chatId,
    required int senderId,
  }) {}

  /// Writes a message to the database.
  ///
  /// Handles incrementing the bucket automatically, also updates the [Chat]'s lastMessage.
  ///
  /// Returns the [ChatMessage] that was written to the database.
  static Future<ChatMessage> _writeMessageToDatabase({
    required Session session,
    required MessageType action,
    required int senderId,
    required int chatId,
    required DateTime sentAt,
    List<int>? targets,
    String? message,
  }) async {
    Chat groupChat = (await Chat.db.findById(session, chatId))!;

    BucketData latestBucket = await getLatestBucket(session, chatId);
    ChatMessage databaseMessage = ChatMessage(
      action: action,
      sentAt: sentAt,
      message: message,
      targets: targets,
      bucket: latestBucket.bucket,
      senderId: senderId,
      chatId: chatId,
    );

    groupChat.lastMessage = sentAt;

    await Chat.db.updateRow(session, groupChat);
    await ChatMessage.db.insertRow(session, databaseMessage);

    _incrementBucket(session, chatId);

    return databaseMessage;
  }

  /// Removes the user from the chat on the database.
  ///
  /// 1. Removes the chat from the [userPersistent].
  /// 2. Removes related last-read timestamps from the [LastRead] table.
  /// 3. Removes references to the user from the given [chat].
  /// 4. Deletes the [chat] from the [Chat] table and all related messages if chat is made empty.
  ///
  /// Does not log messages.
  ///
  /// Returns whether the chat was deleted as a result of removing the user.
  static Future<bool> _removeUserFromChat({
    required Session session,
    required UserPersistent userPersistent,
    required UserInfo userInfo,
    required Chat chat,
  }) async {
    // Remove chat from user
    userPersistent.chats.remove(chat.id);

    // Remove last read timestamps
    LastRead.db.deleteWhere(session,
        where: (row) =>
            (row.chatId.equals(chat.id!)) &
            (row.userInfoId.equals(userInfo.id)));
    await UserPersistent.db.updateRow(session, userPersistent);

    // Remove user from chat
    chat.users.remove(userInfo.id);
    if (chat.users.isEmpty) {
      await ChatMessage.db.deleteWhere(
        session,
        where: (message) => message.chatId.equals(chat.id!),
      );
      await LastRead.db.deleteWhere(
        session,
        where: (row) => row.chatId.equals(chat.id!),
      );
      await Chat.db.deleteRow(session, chat);
      ChatManager.deleteBucket(chat.id!);
    } else {
      if (chat.owners.contains(userInfo.id) && chat.owners.length == 1) {
        chat.owners.add(chat.users.first);
      }

      chat.owners.remove(userInfo.id);

      chat.lastMessage = DateTime.now().toUtc();
      await Chat.db.updateRow(session, chat);

      return true;
    }

    return false;
  }
}
