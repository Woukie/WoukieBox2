// Helps to preserve state of message without having to send additional data per message.
class WrittenMessage {
  final int senderId;
  final String username;
  final String colour;
  final String message;

  WrittenMessage(this.senderId, this.username, this.message, this.colour);
}

class WrittenJoinMessage {
  final int senderId;
  final String username;
  final String colour;

  WrittenJoinMessage(this.senderId, this.username, this.colour);
}

class WrittenLeaveMessage {
  final int senderId;
  final String username;
  final String colour;

  WrittenLeaveMessage(this.senderId, this.username, this.colour);
}

class WrittenProfileMessage {
  final int senderId;
  final String oldUsername;
  final String oldColour;
  final String? newUsername;
  final String? newColour;

  WrittenProfileMessage(
    this.senderId,
    this.oldUsername,
    this.oldColour,
    this.newUsername,
    this.newColour,
  );
}
