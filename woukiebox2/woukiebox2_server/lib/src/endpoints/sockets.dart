import 'dart:math';

import 'package:serverpod_auth_server/module.dart';
import 'package:woukiebox2_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

class SocketsEndpoint extends Endpoint {
  final Random _rnd = Random();

  // https://stackoverflow.com/questions/61919395/how-to-generate-random-string-in-dart
  String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
        ),
      );

  Future<bool> initUser(StreamingSession session) async {
    if (await session.isUserSignedIn) {
      var userId = await session.auth.authenticatedUserId;
      var userInfo = await Users.findUserByUserId(session, userId!);

      if (userInfo != null) {
        setUserObject(session, (
          userId: userInfo.id,
          color: "#FFFF00",
          name: userInfo.userName,
          bio: "not implemented",
          verified: true,
        ));

        print("User info");

        return true;
      }
    }

    print("Could not authenticate user!");

    setUserObject(session, (
      userId: getRandomString(10),
      color: "#00FF00",
      name: "Anonymous",
      bio: "",
      verified: false,
    ));

    return false;
  }

  @override
  Future<void> streamOpened(StreamingSession session) async {
    await initUser(session);

    // Register the session with the global channel
    session.messages.addListener(
      'global',
      (message) {
        sendStreamMessage(session, message);
      },
    );

    print("user joined");

    // Send the client all the members in the room
    sendStreamMessage(
      session,
      RoomMembers(users: [
        User(
          id: "2wad23",
          username: "username",
          bio: "bio",
          colour: "colour",
        ),
        /* TODO: send all members to client */
      ]),
    );

    // TODO: currently just sends a placeholder back to the user. Need to broadcast to ALL users in the channel
    // Broadcast to everyone that a new person has entered the room
    sendStreamMessage(
      session,
      User(
        id: "2wad23",
        username: "username",
        bio: "bio",
        colour: "colour",
      ),
    );
  }

  @override
  Future<void> handleStreamMessage(
    StreamingSession session,
    SerializableEntity message,
  ) async {
    if (message is ChatMessage) {
      session.messages.postMessage(
        'global',
        message,
      );
    }
  }
}
