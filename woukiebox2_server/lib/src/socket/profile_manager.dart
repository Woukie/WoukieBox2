import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';
import 'package:woukiebox2_server/src/generated/protocol.dart';
import 'package:woukiebox2_server/src/socket/session_manager.dart';
import 'package:woukiebox2_server/src/util.dart';

/// Profile-related operations.
class ProfileManager {
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
        sentAt: DateTime.now().toUtc(),
      ),
    );
  }
}
