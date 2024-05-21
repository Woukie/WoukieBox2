/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class ChatMessage extends _i1.SerializableEntity {
  ChatMessage._({
    required this.sender,
    required this.message,
  });

  factory ChatMessage({
    required int sender,
    required String message,
  }) = _ChatMessageImpl;

  factory ChatMessage.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return ChatMessage(
      sender:
          serializationManager.deserialize<int>(jsonSerialization['sender']),
      message: serializationManager
          .deserialize<String>(jsonSerialization['message']),
    );
  }

  int sender;

  String message;

  ChatMessage copyWith({
    int? sender,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'message': message,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'sender': sender,
      'message': message,
    };
  }
}

class _ChatMessageImpl extends ChatMessage {
  _ChatMessageImpl({
    required int sender,
    required String message,
  }) : super._(
          sender: sender,
          message: message,
        );

  @override
  ChatMessage copyWith({
    int? sender,
    String? message,
  }) {
    return ChatMessage(
      sender: sender ?? this.sender,
      message: message ?? this.message,
    );
  }
}
