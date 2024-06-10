/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class LeaveChatServer extends _i1.SerializableEntity {
  LeaveChatServer._({
    required this.sender,
    required this.chat,
  });

  factory LeaveChatServer({
    required int sender,
    required int chat,
  }) = _LeaveChatServerImpl;

  factory LeaveChatServer.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return LeaveChatServer(
      sender:
          serializationManager.deserialize<int>(jsonSerialization['sender']),
      chat: serializationManager.deserialize<int>(jsonSerialization['chat']),
    );
  }

  int sender;

  int chat;

  LeaveChatServer copyWith({
    int? sender,
    int? chat,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'chat': chat,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'sender': sender,
      'chat': chat,
    };
  }
}

class _LeaveChatServerImpl extends LeaveChatServer {
  _LeaveChatServerImpl({
    required int sender,
    required int chat,
  }) : super._(
          sender: sender,
          chat: chat,
        );

  @override
  LeaveChatServer copyWith({
    int? sender,
    int? chat,
  }) {
    return LeaveChatServer(
      sender: sender ?? this.sender,
      chat: chat ?? this.chat,
    );
  }
}
