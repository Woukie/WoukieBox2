import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';
import 'package:woukiebox2_server/src/endpoints/sockets.dart';
import 'package:woukiebox2_server/src/friend_manager.dart';
import 'package:woukiebox2_server/src/generated/protocol.dart';
import 'package:woukiebox2_server/src/util.dart';

// For a less confusing socket implementation
class HandleSocketMessage {
  static chatMessage(
    Session session,
    ChatMessageClient message,
    Function getUserObject,
  ) {
    String trimmedMessage = message.message.trim();

    if (trimmedMessage.isEmpty) return;

    session.messages.postMessage(
      'global',
      ChatMessageServer(
        sender: getUserObject(session).id,
        chat: 0,
        message: trimmedMessage,
      ),
    );
  }

  static Future<void> updateProfile(
    StreamingSession session,
    UpdateProfileClient message,
    Function(Session session) getUserObject,
  ) async {
    // Update the users profile on the database, also note that profile pics are neither cached or updated in UpdateProfile.
    var userId = await session.auth.authenticatedUserId;
    if (userId != null) {
      UserPersistent extraUserData =
          (await Util.getPersistentData(session, userId))!;

      extraUserData.bio = message.bio ?? extraUserData.bio;
      extraUserData.color = message.colour ?? extraUserData.color;

      await UserPersistent.db.updateRow(session, extraUserData);

      if (message.username != null) {
        Users.changeUserName(session, userId, message.username!);
      }
    }

    var sender = getUserObject(session).id;
    // Also update the cached user as some users are anonymous
    UserServer user =
        SocketsEndpoint.connectedUsers.firstWhere((user) => user.id == sender);
    user.bio = message.bio ?? user.bio;
    user.username = message.username ?? user.username;
    user.colour = message.colour ?? user.colour;

    // Tell everyone about the profile change
    session.messages.postMessage(
      'global',
      UpdateProfileServer(
        sender: sender,
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

    Chat chat = await Chat.db.insertRow(
      session,
      Chat(
        users: message.users,
        name: "New Group",
        owner: senderInfo.id!,
      ),
    );

    message.users.add(senderInfo.id!);
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
}
