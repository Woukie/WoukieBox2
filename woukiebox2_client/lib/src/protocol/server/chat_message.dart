/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class ChatMessageServer extends _i1.SerializableEntity {
  ChatMessageServer._({
    required this.sender,
    required this.sentAt,
    required this.chat,
    required this.message,
    this.bucket,
  });

  factory ChatMessageServer({
    required int sender,
    required DateTime sentAt,
    required int chat,
    required String message,
    int? bucket,
  }) = _ChatMessageServerImpl;

  factory ChatMessageServer.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return ChatMessageServer(
      sender:
          serializationManager.deserialize<int>(jsonSerialization['sender']),
      sentAt: serializationManager
          .deserialize<DateTime>(jsonSerialization['sentAt']),
      chat: serializationManager.deserialize<int>(jsonSerialization['chat']),
      message: serializationManager
          .deserialize<String>(jsonSerialization['message']),
      bucket:
          serializationManager.deserialize<int?>(jsonSerialization['bucket']),
    );
  }

  int sender;

  DateTime sentAt;

  int chat;

  String message;

  int? bucket;

  ChatMessageServer copyWith({
    int? sender,
    DateTime? sentAt,
    int? chat,
    String? message,
    int? bucket,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'sentAt': sentAt.toJson(),
      'chat': chat,
      'message': message,
      if (bucket != null) 'bucket': bucket,
    };
  }
}

class _Undefined {}

class _ChatMessageServerImpl extends ChatMessageServer {
  _ChatMessageServerImpl({
    required int sender,
    required DateTime sentAt,
    required int chat,
    required String message,
    int? bucket,
  }) : super._(
          sender: sender,
          sentAt: sentAt,
          chat: chat,
          message: message,
          bucket: bucket,
        );

  @override
  ChatMessageServer copyWith({
    int? sender,
    DateTime? sentAt,
    int? chat,
    String? message,
    Object? bucket = _Undefined,
  }) {
    return ChatMessageServer(
      sender: sender ?? this.sender,
      sentAt: sentAt ?? this.sentAt,
      chat: chat ?? this.chat,
      message: message ?? this.message,
      bucket: bucket is int? ? bucket : this.bucket,
    );
  }
}
