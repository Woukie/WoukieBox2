import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';
import 'package:woukiebox2_server/src/generated/protocol.dart';
import 'package:woukiebox2_server/src/util.dart';

/// Methods for friend status related operations
class FriendManager {
  static Future<void> friendRequest({
    required StreamingSession session,
    required int targetId,
    required bool positive,
  }) async {
    UserInfo? senderInfo = await Util.getAuthUser(session);
    if (senderInfo == null) return;

    UserInfo? targetInfo = await Util.getAuthUser(session, targetId);
    if (targetInfo == null) return;

    // Breaking usual naming scheme for the sake of readability
    UserPersistent sender =
        (await Util.getPersistentData(session, senderInfo.id))!;

    UserPersistent target =
        (await Util.getPersistentData(session, targetInfo.id))!;

    if (positive) {
      if (_areFriends(sender, target) || _hasSentRequestTo(sender, target)) {
        return;
      }

      if (_hasSentRequestTo(target, sender)) {
        _becomeFriends(sender, target);
      } else {
        _sendRequestTo(sender, target);
      }
    } else {
      if (_areFriends(sender, target)) {
        _breakUp(sender, target);
      } else if (_hasSentRequestTo(target, sender)) {
        _cancelRequestTo(target, sender);
      } else if (_hasSentRequestTo(sender, target)) {
        _cancelRequestTo(sender, target);
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

  // Breaks up the friendship
  static _breakUp(UserPersistent user1, UserPersistent user2) {
    user1.friends.remove(user2.userInfoId);
    user2.friends.remove(user1.userInfoId);
  }

  // Registers the two as friends
  static _becomeFriends(UserPersistent user1, UserPersistent user2) {
    user1.friends.add(user2.userInfoId);
    user2.friends.add(user1.userInfoId);

    user1.outgoingFriendRequests.remove(user2.userInfoId);
    user2.outgoingFriendRequests.remove(user1.userInfoId);

    user1.incomingFriendRequests.remove(user2.userInfoId);
    user2.incomingFriendRequests.remove(user1.userInfoId);
  }

  // Check if two users are friends
  static bool _areFriends(UserPersistent user1, UserPersistent user2) {
    return user1.friends.contains(user2.userInfoId) ||
        user2.friends.contains(user1.userInfoId);
  }

  // Whether the sender has sent a friend request to the specified person
  static bool _hasSentRequestTo(UserPersistent from, UserPersistent to) {
    return from.outgoingFriendRequests.contains(to.userInfoId) ||
        to.incomingFriendRequests.contains(from.userInfoId);
  }

  // Cancels the friend request to said user
  static _cancelRequestTo(UserPersistent from, UserPersistent to) {
    from.outgoingFriendRequests.remove(to.userInfoId);
    to.incomingFriendRequests.remove(from.userInfoId);
  }

  // Sends a friend request to the target, from the sender
  static _sendRequestTo(UserPersistent from, UserPersistent to) {
    from.outgoingFriendRequests.add(to.userInfoId);
    to.incomingFriendRequests.add(from.userInfoId);
  }
}
