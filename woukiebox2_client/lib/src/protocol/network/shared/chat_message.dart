/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../protocol.dart' as _i2;

abstract class NetworkChatMessage extends _i1.SerializableEntity {
  NetworkChatMessage._({
    required this.action,
    required this.sender,
    this.sentAt,
    required this.chat,
    this.message,
    this.targets,
    this.bucket,
  });

  factory NetworkChatMessage({
    required _i2.MessageType action,
    required int sender,
    DateTime? sentAt,
    required int chat,
    String? message,
    List<int>? targets,
    int? bucket,
  }) = _NetworkChatMessageImpl;

  factory NetworkChatMessage.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return NetworkChatMessage(
      action: serializationManager
          .deserialize<_i2.MessageType>(jsonSerialization['action']),
      sender:
          serializationManager.deserialize<int>(jsonSerialization['sender']),
      sentAt: serializationManager
          .deserialize<DateTime?>(jsonSerialization['sentAt']),
      chat: serializationManager.deserialize<int>(jsonSerialization['chat']),
      message: serializationManager
          .deserialize<String?>(jsonSerialization['message']),
      targets: serializationManager
          .deserialize<List<int>?>(jsonSerialization['targets']),
      bucket:
          serializationManager.deserialize<int?>(jsonSerialization['bucket']),
    );
  }

  /// The action that is intended by this message
  _i2.MessageType action;

  /// ID representing the user that initiated the message.
  int sender;

  /// Time stamp for when the message was sent. Server always sends this.
  DateTime? sentAt;

  /// Chat ID of the destination, 0 = global.
  int chat;

  /// The content of an action if needed, potentially message, or rename chat action.
  String? message;

  /// Target list corresponding to the ID of the user target(s) of an action, if applicable.
  List<int>? targets;

  /// Not null when recieved by the server or for global messages, indicates what bucket the message was stored in on the server.
  int? bucket;

  NetworkChatMessage copyWith({
    _i2.MessageType? action,
    int? sender,
    DateTime? sentAt,
    int? chat,
    String? message,
    List<int>? targets,
    int? bucket,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'action': action.toJson(),
      'sender': sender,
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
      'chat': chat,
      if (message != null) 'message': message,
      if (targets != null) 'targets': targets?.toJson(),
      if (bucket != null) 'bucket': bucket,
    };
  }
}

class _Undefined {}

class _NetworkChatMessageImpl extends NetworkChatMessage {
  _NetworkChatMessageImpl({
    required _i2.MessageType action,
    required int sender,
    DateTime? sentAt,
    required int chat,
    String? message,
    List<int>? targets,
    int? bucket,
  }) : super._(
          action: action,
          sender: sender,
          sentAt: sentAt,
          chat: chat,
          message: message,
          targets: targets,
          bucket: bucket,
        );

  @override
  NetworkChatMessage copyWith({
    _i2.MessageType? action,
    int? sender,
    Object? sentAt = _Undefined,
    int? chat,
    Object? message = _Undefined,
    Object? targets = _Undefined,
    Object? bucket = _Undefined,
  }) {
    return NetworkChatMessage(
      action: action ?? this.action,
      sender: sender ?? this.sender,
      sentAt: sentAt is DateTime? ? sentAt : this.sentAt,
      chat: chat ?? this.chat,
      message: message is String? ? message : this.message,
      targets: targets is List<int>? ? targets : this.targets?.clone(),
      bucket: bucket is int? ? bucket : this.bucket,
    );
  }
}
