/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod_serialization/serverpod_serialization.dart';

abstract class PromoteChatMemberServer extends _i1.SerializableEntity {
  PromoteChatMemberServer._({
    required this.chat,
    required this.sender,
    required this.target,
    required this.sentAt,
  });

  factory PromoteChatMemberServer({
    required int chat,
    required int sender,
    required int target,
    required DateTime sentAt,
  }) = _PromoteChatMemberServerImpl;

  factory PromoteChatMemberServer.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return PromoteChatMemberServer(
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

  PromoteChatMemberServer copyWith({
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

  @override
  Map<String, dynamic> allToJson() {
    return {
      'chat': chat,
      'sender': sender,
      'target': target,
      'sentAt': sentAt.toJson(),
    };
  }
}

class _PromoteChatMemberServerImpl extends PromoteChatMemberServer {
  _PromoteChatMemberServerImpl({
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
  PromoteChatMemberServer copyWith({
    int? chat,
    int? sender,
    int? target,
    DateTime? sentAt,
  }) {
    return PromoteChatMemberServer(
      chat: chat ?? this.chat,
      sender: sender ?? this.sender,
      target: target ?? this.target,
      sentAt: sentAt ?? this.sentAt,
    );
  }
}
