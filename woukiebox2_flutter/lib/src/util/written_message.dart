abstract class BaseMessage {
  final int senderId;
  final DateTime sentAt;

  BaseMessage({
    required this.senderId,
    required this.sentAt,
  });
}

class ChatMessage extends BaseMessage {
  final int bucket;
  final String message;
  final String? image, username, color;

  ChatMessage({
    this.image,
    this.username,
    this.color,
    required this.bucket,
    required this.message,
    required super.senderId,
    required super.sentAt,
  });
}

class JoinMessage extends BaseMessage {
  final String username;
  final String colour;

  JoinMessage({
    required this.username,
    required this.colour,
    required super.senderId,
    required super.sentAt,
  });
}

class LeaveMessage extends BaseMessage {
  final String username;
  final String colour;

  LeaveMessage({
    required this.username,
    required this.colour,
    required super.senderId,
    required super.sentAt,
  });
}

class ProfileMessage extends BaseMessage {
  final String oldUsername;
  final String oldColour;
  final String? newUsername;
  final String? newColour;

  ProfileMessage({
    required this.oldUsername,
    required this.oldColour,
    this.newUsername,
    this.newColour,
    required super.senderId,
    required super.sentAt,
  });
}
