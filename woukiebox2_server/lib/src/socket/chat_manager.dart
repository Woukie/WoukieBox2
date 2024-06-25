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
          targets: chat.owners,
          sender: senderId,
          chat: chatId,
        ),
      );
    }
  }

  static Future<void> promoteUser({
    required StreamingSession session,
    required int chatId,
    required int targetId,
    required int senderId,
  }) async {
    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return;

    UserInfo? targetInfo = await Util.getAuthUser(session, targetId);
    if (targetInfo == null) return;

    DateTime now = DateTime.now().toUtc();

    Chat? groupChat = await Chat.db.findById(session, chatId);
    if (groupChat == null) return;

    if (!groupChat.owners.contains(senderId)) return;
    if (groupChat.owners.contains(targetId)) return;
    if (!groupChat.users.contains(targetId)) return;

    groupChat.lastMessage = now;
    groupChat.owners.add(targetInfo.id!);
    await Chat.db.updateRow(session, groupChat);

    ChatMessage chatMessage = await _writeMessageToDatabase(
      session: session,
      action: MessageType.Promote,
      senderId: senderId,
      targets: [targetId],
      chatId: chatId,
      sentAt: DateTime.now().toUtc(),
    );

    for (int user in groupChat.users) {
      session.messages.postMessage(
        user.toString(),
        NetworkChatMessage(
          action: MessageType.Promote,
          sender: senderId,
          targets: [targetId],
          chat: chatId,
          sentAt: chatMessage.sentAt,
          bucket: chatMessage.bucket,
        ),
      );
    }
  }

  static Future<void> addFriends({
    required StreamingSession session,
    required int chatId,
    required List<int> targetIds,
    required int senderId,
  }) async {
    if (targetIds.isEmpty) return;

    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return;

    UserPersistent senderPersistent = (await Util.getPersistentData(session))!;

    Chat? chat = await Chat.db.findById(session, senderId);
    if (chat == null) return;

    if (!chat.owners.contains(senderInfo.id)) return;

    for (int target in targetIds) {
      if (chat.users.contains(target) ||
          !senderPersistent.friends.contains(target)) return;
    }

    DateTime now = DateTime.now().toUtc();
    chat.users.addAll(targetIds);
    for (int target in targetIds) {
      UserPersistent? targetPersistent =
          await Util.getPersistentData(session, target);
      if (targetPersistent == null) continue;
      targetPersistent.chats.add(chat.id!);
      UserPersistent.db.updateRow(session, targetPersistent);
    }
    chat.lastMessage = now;
    await Chat.db.updateRow(session, chat);

    ChatMessage chatMessage = await _writeMessageToDatabase(
      session: session,
      action: MessageType.AddFriends,
      senderId: senderId,
      chatId: chatId,
      sentAt: DateTime.now().toUtc(),
      targets: targetIds,
    );

    for (int user in chat.users) {
      if (targetIds.contains(user)) {
        session.messages.postMessage(
          user.toString(),
          CreateChatServer(
            chat: chat,
          ),
        );
      } else {
        session.messages.postMessage(
          user.toString(),
          NetworkChatMessage(
            action: MessageType.AddFriends,
            sender: senderId,
            chat: chatId,
            bucket: chatMessage.bucket,
            sentAt: chatMessage.sentAt,
            targets: targetIds,
          ),
        );
      }
    }
  }

  static Future<void> renameChat({
    required StreamingSession session,
    required String name,
    required int chatId,
    required int senderId,
  }) async {
    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return;

    UserPersistent senderPersistent =
        (await Util.getPersistentData(session, senderInfo.id))!;

    if (!senderPersistent.chats.contains(chatId)) return;

    Chat? chat = await Chat.db.findById(session, chatId);
    if (chat == null || !chat.owners.contains(senderInfo.id)) return;

    name = name.trim();
    chat.name = name;
    await Chat.db.updateRow(session, chat);

    ChatMessage chatMessage = await _writeMessageToDatabase(
      session: session,
      action: MessageType.Rename,
      message: name,
      senderId: senderId,
      chatId: chatId,
      sentAt: DateTime.now().toUtc(),
    );

    for (int user in chat.users) {
      session.messages.postMessage(
        user.toString(),
        NetworkChatMessage(
          action: MessageType.Rename,
          sender: senderId,
          chat: chatId,
          bucket: chatMessage.bucket,
          message: name,
          sentAt: chatMessage.sentAt,
        ),
      );
    }
  }

  static Future<void> createChat({
    required StreamingSession session,
    required String name,
    required int senderId,
    required List<int> targetIds,
  }) async {
    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return;

    UserPersistent senderPersistent = (await Util.getPersistentData(session))!;

    // Can only create a group with friends
    for (var target in targetIds) {
      if (!senderPersistent.friends.contains(target)) return;
    }

    targetIds.add(senderInfo.id!);

    Chat chat = await Chat.db.insertRow(
      session,
      Chat(
        users: targetIds,
        name: name.trim(),
        creator: senderId,
        owners: [senderId],
        lastMessage: DateTime.now().toUtc(),
      ),
    );

    _writeMessageToDatabase(
      session: session,
      action: MessageType.Create,
      senderId: senderId,
      chatId: chat.id!,
      sentAt: chat.lastMessage,
    );

    for (int target in targetIds) {
      UserPersistent? targetPersistent = await Util.getPersistentData(
        session,
        target,
      );

      if (targetPersistent == null) continue;

      targetPersistent.chats.add(chat.id!);
      await UserPersistent.db.updateRow(session, targetPersistent);

      session.messages.postMessage(
        target.toString(),
        CreateChatServer(chat: chat),
      );
    }
  }

  static Future<void> readChat({
    required StreamingSession session,
    required int chat,
  }) async {
    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return;

    UserPersistent senderPersistent =
        (await Util.getPersistentData(session, senderInfo.id))!;

    if (!senderPersistent.chats.contains(chat)) return;

    LastRead? existingLastRead = await LastRead.db.findFirstRow(
      session,
      where: (row) =>
          (row.chatId.equals(chat)) & (row.userInfoId.equals(senderInfo.id)),
    );

    DateTime readAt = DateTime.now().toUtc();

    if (existingLastRead == null) {
      await LastRead.db.insertRow(
        session,
        LastRead(
          userInfoId: senderInfo.id!,
          chatId: chat,
          readAt: readAt,
        ),
      );
    } else {
      existingLastRead.readAt = readAt;
      await LastRead.db.updateRow(session, existingLastRead);
    }

    session.messages.postMessage(
      senderInfo.id.toString(),
      ReadChatServer(chat: chat, readAt: readAt),
    );
  }

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
