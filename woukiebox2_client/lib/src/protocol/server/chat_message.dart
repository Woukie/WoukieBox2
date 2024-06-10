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
    required this.chat,
    required this.message,
  });

  factory ChatMessageServer({
    required int sender,
    required int chat,
    required String message,
  }) = _ChatMessageServerImpl;

  factory ChatMessageServer.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return ChatMessageServer(
      sender:
          serializationManager.deserialize<int>(jsonSerialization['sender']),
      chat: serializationManager.deserialize<int>(jsonSerialization['chat']),
      message: serializationManager
          .deserialize<String>(jsonSerialization['message']),
    );
  }

  int sender;

  int chat;

  String message;

  ChatMessageServer copyWith({
    int? sender,
    int? chat,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'chat': chat,
      'message': message,
    };
  }
}

class _ChatMessageServerImpl extends ChatMessageServer {
  _ChatMessageServerImpl({
    required int sender,
    required int chat,
    required String message,
  }) : super._(
          sender: sender,
          chat: chat,
          message: message,
        );

  @override
  ChatMessageServer copyWith({
    int? sender,
    int? chat,
    String? message,
  }) {
    return ChatMessageServer(
      sender: sender ?? this.sender,
      chat: chat ?? this.chat,
      message: message ?? this.message,
    );
  }
}
