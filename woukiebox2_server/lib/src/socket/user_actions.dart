import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';
import 'package:woukiebox2_server/src/friend_manager.dart';
import 'package:woukiebox2_server/src/generated/protocol.dart';
import 'package:woukiebox2_server/src/socket/chat_message_manager.dart';
import 'package:woukiebox2_server/src/socket/session_manager.dart';
import 'package:woukiebox2_server/src/util.dart';

// For a less confusing socket implementation
class UserActions {
  static chatMessage(
    Session session,
    ChatMessageClient message,
    int userId,
  ) async {
    if (message.target == 0) {
      ChatMessageManager.sendGlobalMessage(session, message, userId);
    } else {
      ChatMessageManager.sendChatMessage(session, message);
    }
  }

  static Future<void> updateProfile(
    StreamingSession session,
    UpdateProfileClient message,
    int userId,
  ) async {
    // Update the users profile on the database, also note that profile pics are neither cached or updated in UpdateProfile.
    var authUserId = await session.auth.authenticatedUserId;
    if (authUserId != null) {
      UserPersistent extraUserData =
          (await Util.getPersistentData(session, authUserId))!;

      extraUserData.bio = message.bio ?? extraUserData.bio;
      extraUserData.color = message.colour ?? extraUserData.color;

      await UserPersistent.db.updateRow(session, extraUserData);

      if (message.username != null) {
        Users.changeUserName(session, authUserId, message.username!);
      }
    }

    // Also update the cached user as some users are anonymous
    UserServer user =
        SessionManager.connectedUsers.firstWhere((user) => user.id == userId);
    user.bio = message.bio ?? user.bio;
    user.username = message.username ?? user.username;
    user.colour = message.colour ?? user.colour;

    // Tell everyone about the profile change
    session.messages.postMessage(
      'global',
      UpdateProfileServer(
        sender: userId,
        username: message.username,
        bio: message.bio,
        colour: message.colour,
      ),
    );
  }

  static Future<void> friendRequest(
    StreamingSession session,
    FriendRequestClient message,
  ) async {
    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return;

    UserInfo? targetInfo = await Util.getAuthUser(session, message.target);
    if (targetInfo == null) return;

    // Breaking usual naming scheme for the sake of readability
    UserPersistent sender =
        (await Util.getPersistentData(session, senderInfo.id))!;

    UserPersistent target =
        (await Util.getPersistentData(session, targetInfo.id))!;

    if (message.positive) {
      if (Friends.areFriends(sender, target) ||
          Friends.hasSentRequestTo(sender, target)) return;

      if (Friends.hasSentRequestTo(target, sender)) {
        Friends.becomeFriends(sender, target);
      } else {
        Friends.sendRequestTo(sender, target);
      }
    } else {
      if (Friends.areFriends(sender, target)) {
        Friends.breakUp(sender, target);
      } else if (Friends.hasSentRequestTo(target, sender)) {
        Friends.cancelRequestTo(target, sender);
      } else if (Friends.hasSentRequestTo(sender, target)) {
        Friends.cancelRequestTo(sender, target);
      } else {
        return;
      }
    }

    await UserPersistent.db.updateRow(session, sender);
    await UserPersistent.db.updateRow(session, target);

    session.messages.postMessage(
      sender.userInfoId.toString(),
      FriendListServer(
        friends: sender.friends,
        incomingFriendRequests: sender.incomingFriendRequests,
        outgoingFriendRequests: sender.outgoingFriendRequests,
      ),
    );

    session.messages.postMessage(
      target.userInfoId.toString(),
      FriendListServer(
        friends: target.friends,
        incomingFriendRequests: target.incomingFriendRequests,
        outgoingFriendRequests: target.outgoingFriendRequests,
      ),
    );
  }

  static Future<void> createChat(
      StreamingSession session, CreateChatClient message) async {
    // Must be authenticated
    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return;

    UserPersistent senderPersistent =
        (await Util.getPersistentData(session, senderInfo.id))!;

    // Can only create a group with friends
    for (var target in message.users) {
      if (!senderPersistent.friends.contains(target)) return;
    }

    message.users.add(senderInfo.id!);

    if (!message.owners.contains(senderInfo.id)) {
      message.owners.add(senderInfo.id!);
    }

    Chat chat = await Chat.db.insertRow(
      session,
      Chat(
        users: message.users,
        name: message.name.trim(),
        creator: senderInfo.id!,
        owners: message.owners,
        lastMessage: DateTime.now().toUtc(),
      ),
    );

    for (int target in message.users) {
      UserPersistent? targetPersistent = await Util.getPersistentData(
        session,
        target,
      );

      // Will be null if user was deleted but not removed from their friend's friend lists
      if (targetPersistent == null) continue;

      targetPersistent.chats.add(chat.id!);
      await UserPersistent.db.updateRow(session, targetPersistent);

      session.messages.postMessage(
        target.toString(),
        CreateChatServer(chat: chat),
      );
    }
  }

  static Future<void> leaveChat(
    StreamingSession session,
    LeaveChatClient message,
  ) async {
    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return;

    UserPersistent senderPersistent =
        (await Util.getPersistentData(session, senderInfo.id))!;

    if (!senderPersistent.chats.contains(message.chat)) return;

    Chat? chat = await Chat.db.findById(session, message.chat);
    if (chat == null) return;

    await _removeUserFromChat(chat, senderInfo, senderPersistent, session);

    chat.users.add(senderInfo.id!);
    for (int user in chat.users) {
      session.messages.postMessage(
        user.toString(),
        LeaveChatServer(
          chat: chat.id!,
          sender: senderInfo.id!,
          owners: chat.owners,
          sentAt: chat.lastMessage,
        ),
      );
    }
  }

  static Future<void> renameChat(
      StreamingSession session, RenameChat message) async {
    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return;

    UserPersistent senderPersistent =
        (await Util.getPersistentData(session, senderInfo.id))!;

    if (!senderPersistent.chats.contains(message.chat)) return;

    Chat? chat = await Chat.db.findById(session, message.chat);
    if (chat == null || !chat.owners.contains(senderInfo.id)) return;

    chat.name = message.name.trim();
    await Chat.db.updateRow(session, chat);

    for (int user in chat.users) {
      session.messages.postMessage(
        user.toString(),
        RenameChat(
          chat: chat.id!,
          name: chat.name,
        ),
      );
    }
  }

  static Future<void> readChat(
      StreamingSession session, ReadChatClient message) async {
    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return;

    UserPersistent senderPersistent =
        (await Util.getPersistentData(session, senderInfo.id))!;

    if (!senderPersistent.chats.contains(message.chat)) return;

    LastRead? existingLastRead = await LastRead.db.findFirstRow(
      session,
      where: (row) =>
          (row.chatId.equals(message.chat)) &
          (row.userInfoId.equals(senderInfo.id)),
    );

    DateTime readAt = DateTime.now().toUtc();

    if (existingLastRead == null) {
      await LastRead.db.insertRow(
        session,
        LastRead(
          userInfoId: senderInfo.id!,
          chatId: message.chat,
          readAt: readAt,
        ),
      );
    } else {
      existingLastRead.readAt = readAt;
      await LastRead.db.updateRow(session, existingLastRead);
    }

    session.messages.postMessage(
      senderInfo.id.toString(),
      ReadChatServer(chat: message.chat, readAt: readAt),
    );
  }

  static Future<void> kickChatMember(
    StreamingSession session,
    KickChatMemberClient message,
  ) async {
    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return;

    UserInfo? targetInfo = await Util.getAuthUser(session, message.user);
    if (targetInfo == null) return;

    UserPersistent targetPersistent =
        (await Util.getPersistentData(session, targetInfo.id))!;

    Chat? chat = await Chat.db.findById(session, message.chat);
    if (chat == null ||
        !chat.owners.contains(senderInfo.id) ||
        !chat.users.contains(targetInfo.id) ||
        chat.owners.contains(targetInfo.id)) return;

    await _removeUserFromChat(chat, targetInfo, targetPersistent, session);

    chat.users.add(targetInfo.id!);
    for (int user in chat.users) {
      session.messages.postMessage(
        user.toString(),
        KickChatMemberServer(
          chat: chat.id!,
          sender: senderInfo.id!,
          target: targetInfo.id!,
          sentAt: DateTime.now().toUtc(),
        ),
      );
    }
  }

  static void promoteChatMember(
    StreamingSession session,
    PromoteChatMemberClient message,
  ) {}

  static void addChatMembers(
    StreamingSession session,
    AddChatMembersClient message,
  ) {}

  static Future<void> _removeUserFromChat(
    Chat chat,
    UserInfo userInfo,
    UserPersistent userPersistent,
    StreamingSession session,
  ) async {
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
      ChatMessageManager.deleteBucket(chat.id!);
    } else {
      if (chat.owners.contains(userInfo.id) && chat.owners.length == 1) {
        chat.owners.add(chat.users.first);
      }

      chat.lastMessage = DateTime.now().toUtc();
      await Chat.db.updateRow(session, chat);
    }

    // Remove chat from user
    userPersistent.chats.remove(chat.id);
    LastRead.db.deleteWhere(session,
        where: (row) =>
            (row.chatId.equals(chat.id!)) &
            (row.userInfoId.equals(userInfo.id)));
    await UserPersistent.db.updateRow(session, userPersistent);
  }
}
