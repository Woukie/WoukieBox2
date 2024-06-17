// Helps to preserve state of message without having to send additional data per message.
class WrittenGlobalMessage {
  final int senderId;
  final String username;
  final String colour;
  final String message;
  final String image; // Lead messages have images
  final DateTime sentAt;

  WrittenGlobalMessage(
    this.senderId,
    this.username,
    this.message,
    this.colour,
    this.image,
    this.sentAt,
  );
}

// Written CHAT messages can't preserve cached data like old names and profile pics, so we can just use an ID for user info and let the message box figure it out
class WrittenChatMessage {
  final int senderId, bucket;
  final String message;
  final DateTime sentAt;

  WrittenChatMessage(
    this.senderId,
    this.message,
    this.bucket,
    this.sentAt,
  );
}

class WrittenJoinMessage {
  final int senderId;
  final String username;
  final String colour;
  final DateTime sentAt;

  WrittenJoinMessage(this.senderId, this.username, this.colour, this.sentAt);
}

class WrittenLeaveMessage {
  final int senderId;
  final String username;
  final String colour;
  final DateTime sentAt;

  WrittenLeaveMessage(this.senderId, this.username, this.colour, this.sentAt);
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
