// Simlifies friendship management
import 'package:woukiebox2_server/src/generated/protocol.dart';

// Inputs are all UserPersistant because that is convenient in the context they are used in (socket_messages friend message)
// Also can't belive models don't support sets. Theres probably no duplicate value issues but you never know
class Friends {
  // Breaks up the friendship
  static breakUp(UserPersistent user1, UserPersistent user2) {
    user1.friends.remove(user2.userInfoId);
    user2.friends.remove(user1.userInfoId);
  }

  // Registers the two as friends
  static becomeFriends(UserPersistent user1, UserPersistent user2) {
    user1.friends.add(user2.userInfoId);
    user2.friends.add(user1.userInfoId);

    user1.outgoingFriendRequests.remove(user2.userInfoId);
    user2.outgoingFriendRequests.remove(user1.userInfoId);

    user1.incomingFriendRequests.remove(user2.userInfoId);
    user2.incomingFriendRequests.remove(user1.userInfoId);
  }

  // Check if two users are friends
  static bool areFriends(UserPersistent user1, UserPersistent user2) {
    return user1.friends.contains(user2.userInfoId) ||
        user2.friends.contains(user1.userInfoId);
  }

  // Whether the sender has sent a friend request to the specified person
  static bool hasSentRequestTo(UserPersistent from, UserPersistent to) {
    return from.outgoingFriendRequests.contains(to.userInfoId) ||
        to.incomingFriendRequests.contains(from.userInfoId);
  }

  // Cancels the friend request to said user
  static cancelRequestTo(UserPersistent from, UserPersistent to) {
    from.outgoingFriendRequests.remove(to.userInfoId);
    to.incomingFriendRequests.remove(from.userInfoId);
  }

  // Sends a friend request to the target, from the sender
  static sendRequestTo(UserPersistent from, UserPersistent to) {
    from.outgoingFriendRequests.add(to.userInfoId);
    to.incomingFriendRequests.add(from.userInfoId);
  }
}
