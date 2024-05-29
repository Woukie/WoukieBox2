/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class ChatMessage extends _i1.SerializableEntity {
  ChatMessage._({
    this.sender,
    required this.message,
  });

  factory ChatMessage({
    int? sender,
    required String message,
  }) = _ChatMessageImpl;

  factory ChatMessage.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return ChatMessage(
      sender:
          serializationManager.deserialize<int?>(jsonSerialization['sender']),
      message: serializationManager
          .deserialize<String>(jsonSerialization['message']),
    );
  }

  int? sender;

  String message;

  ChatMessage copyWith({
    int? sender,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (sender != null) 'sender': sender,
      'message': message,
    };
  }
}

class _Undefined {}

class _ChatMessageImpl extends ChatMessage {
  _ChatMessageImpl({
    int? sender,
    required String message,
  }) : super._(
          sender: sender,
          message: message,
        );

  @override
  ChatMessage copyWith({
    Object? sender = _Undefined,
    String? message,
  }) {
    return ChatMessage(
      sender: sender is int? ? sender : this.sender,
      message: message ?? this.message,
    );
  }
}
