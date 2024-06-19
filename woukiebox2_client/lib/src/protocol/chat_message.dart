/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'protocol.dart' as _i2;

abstract class ChatMessage extends _i1.SerializableEntity {
  ChatMessage._({
    this.id,
    required this.sentAt,
    required this.message,
    required this.senderId,
    this.sender,
    required this.chatId,
    this.chat,
    required this.bucket,
  });

  factory ChatMessage({
    int? id,
    required DateTime sentAt,
    required String message,
    required int senderId,
    _i2.UserPersistent? sender,
    required int chatId,
    _i2.Chat? chat,
    required int bucket,
  }) = _ChatMessageImpl;

  factory ChatMessage.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return ChatMessage(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      sentAt: serializationManager
          .deserialize<DateTime>(jsonSerialization['sentAt']),
      message: serializationManager
          .deserialize<String>(jsonSerialization['message']),
      senderId:
          serializationManager.deserialize<int>(jsonSerialization['senderId']),
      sender: serializationManager
          .deserialize<_i2.UserPersistent?>(jsonSerialization['sender']),
      chatId:
          serializationManager.deserialize<int>(jsonSerialization['chatId']),
      chat: serializationManager
          .deserialize<_i2.Chat?>(jsonSerialization['chat']),
      bucket:
          serializationManager.deserialize<int>(jsonSerialization['bucket']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  DateTime sentAt;

  String message;

  int senderId;

  _i2.UserPersistent? sender;

  int chatId;

  _i2.Chat? chat;

  int bucket;

  ChatMessage copyWith({
    int? id,
    DateTime? sentAt,
    String? message,
    int? senderId,
    _i2.UserPersistent? sender,
    int? chatId,
    _i2.Chat? chat,
    int? bucket,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'sentAt': sentAt.toJson(),
      'message': message,
      'senderId': senderId,
      if (sender != null) 'sender': sender?.toJson(),
      'chatId': chatId,
      if (chat != null) 'chat': chat?.toJson(),
      'bucket': bucket,
    };
  }
}

class _Undefined {}

class _ChatMessageImpl extends ChatMessage {
  _ChatMessageImpl({
    int? id,
    required DateTime sentAt,
    required String message,
    required int senderId,
    _i2.UserPersistent? sender,
    required int chatId,
    _i2.Chat? chat,
    required int bucket,
  }) : super._(
          id: id,
          sentAt: sentAt,
          message: message,
          senderId: senderId,
          sender: sender,
          chatId: chatId,
          chat: chat,
          bucket: bucket,
        );

  @override
  ChatMessage copyWith({
    Object? id = _Undefined,
    DateTime? sentAt,
    String? message,
    int? senderId,
    Object? sender = _Undefined,
    int? chatId,
    Object? chat = _Undefined,
    int? bucket,
  }) {
    return ChatMessage(
      id: id is int? ? id : this.id,
      sentAt: sentAt ?? this.sentAt,
      message: message ?? this.message,
      senderId: senderId ?? this.senderId,
      sender: sender is _i2.UserPersistent? ? sender : this.sender?.copyWith(),
      chatId: chatId ?? this.chatId,
      chat: chat is _i2.Chat? ? chat : this.chat?.copyWith(),
      bucket: bucket ?? this.bucket,
    );
  }
}
