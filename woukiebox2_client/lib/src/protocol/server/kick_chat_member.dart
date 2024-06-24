/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class KickChatMemberServer extends _i1.SerializableEntity {
  KickChatMemberServer._({
    required this.chat,
    required this.sender,
    required this.target,
    required this.sentAt,
  });

  factory KickChatMemberServer({
    required int chat,
    required int sender,
    required int target,
    required DateTime sentAt,
  }) = _KickChatMemberServerImpl;

  factory KickChatMemberServer.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return KickChatMemberServer(
      chat: serializationManager.deserialize<int>(jsonSerialization['chat']),
      sender:
          serializationManager.deserialize<int>(jsonSerialization['sender']),
      target:
          serializationManager.deserialize<int>(jsonSerialization['target']),
      sentAt: serializationManager
          .deserialize<DateTime>(jsonSerialization['sentAt']),
    );
  }

  int chat;

  int sender;

  int target;

  DateTime sentAt;

  KickChatMemberServer copyWith({
    int? chat,
    int? sender,
    int? target,
    DateTime? sentAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'chat': chat,
      'sender': sender,
      'target': target,
      'sentAt': sentAt.toJson(),
    };
  }
}

class _KickChatMemberServerImpl extends KickChatMemberServer {
  _KickChatMemberServerImpl({
    required int chat,
    required int sender,
    required int target,
    required DateTime sentAt,
  }) : super._(
          chat: chat,
          sender: sender,
          target: target,
          sentAt: sentAt,
        );

  @override
  KickChatMemberServer copyWith({
    int? chat,
    int? sender,
    int? target,
    DateTime? sentAt,
  }) {
    return KickChatMemberServer(
      chat: chat ?? this.chat,
      sender: sender ?? this.sender,
      target: target ?? this.target,
      sentAt: sentAt ?? this.sentAt,
    );
  }
}
