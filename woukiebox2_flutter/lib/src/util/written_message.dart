import 'package:woukiebox2_client/woukiebox2_client.dart' as protocol;

abstract class BaseMessage {
  final int senderId, bucket;
  final DateTime sentAt;

  BaseMessage({
    required this.senderId,
    required this.bucket,
    required this.sentAt,
  });

  static BaseMessage serverToWritten(protocol.ChatMessage message) {
    if (message.addTargets != null) {
      return AddUsersMessage(
        senderId: message.senderId,
        sentAt: message.sentAt,
        bucket: message.bucket,
        users: message.addTargets!,
      );
    } else if (message.kickTarget != null) {
      return KickMessage(
        senderId: message.senderId,
        sentAt: message.sentAt,
        bucket: message.bucket,
        target: message.kickTarget!,
      );
    } else if (message.promoteTarget != null) {
      return PromoteMessage(
        senderId: message.senderId,
        sentAt: message.sentAt,
        bucket: message.bucket,
        target: message.kickTarget!,
      );
    }

    return ChatMessage(
      bucket: message.bucket,
      message: message.message!,
      senderId: message.senderId,
      sentAt: message.sentAt,
    );
  }
}

class ChatMessage extends BaseMessage {
  final String message;
  final String? image, username, color;

  ChatMessage({
    this.image,
    this.username,
    this.color,
    required this.message,
    required super.bucket,
    required super.senderId,
    required super.sentAt,
  });
}

class JoinMessage extends BaseMessage {
  final String username;
  final String colour;

  JoinMessage({
    super.bucket = 0,
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
    super.bucket = 0,
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
    this.newUsername,
    this.newColour,
    required this.oldUsername,
    required this.oldColour,
    super.bucket = 0,
    required super.senderId,
    required super.sentAt,
  });
}

class AddUsersMessage extends BaseMessage {
  final List<int> users;

  AddUsersMessage({
    required super.senderId,
    required super.sentAt,
    required super.bucket,
    required this.users,
  });
}

class KickMessage extends BaseMessage {
  final int target;

  KickMessage({
    required super.senderId,
    required super.sentAt,
    required super.bucket,
    required this.target,
  });
}

class PromoteMessage extends BaseMessage {
  final int target;

  PromoteMessage({
    required super.senderId,
    required super.sentAt,
    required super.bucket,
    required this.target,
  });
}
