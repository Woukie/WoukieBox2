import 'package:woukiebox2_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class SocketsEndpoint extends Endpoint {
  @override
  Future<void> streamOpened(StreamingSession session) async {
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
