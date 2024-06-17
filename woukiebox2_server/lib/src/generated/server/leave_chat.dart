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

abstract class LeaveChatServer extends _i1.SerializableEntity {
  LeaveChatServer._({
    required this.sender,
    required this.chat,
    this.owners,
    required this.sentAt,
  });

  factory LeaveChatServer({
    required int sender,
    required int chat,
    List<int>? owners,
    required DateTime sentAt,
  }) = _LeaveChatServerImpl;

  factory LeaveChatServer.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return LeaveChatServer(
      sender:
          serializationManager.deserialize<int>(jsonSerialization['sender']),
      chat: serializationManager.deserialize<int>(jsonSerialization['chat']),
      owners: serializationManager
          .deserialize<List<int>?>(jsonSerialization['owners']),
      sentAt: serializationManager
          .deserialize<DateTime>(jsonSerialization['sentAt']),
    );
  }

  int sender;

  int chat;

  List<int>? owners;

  DateTime sentAt;

  LeaveChatServer copyWith({
    int? sender,
    int? chat,
    List<int>? owners,
    DateTime? sentAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'chat': chat,
      if (owners != null) 'owners': owners?.toJson(),
      'sentAt': sentAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'sender': sender,
      'chat': chat,
      if (owners != null) 'owners': owners?.toJson(),
      'sentAt': sentAt.toJson(),
    };
  }
}

class _Undefined {}

class _LeaveChatServerImpl extends LeaveChatServer {
  _LeaveChatServerImpl({
    required int sender,
    required int chat,
    List<int>? owners,
    required DateTime sentAt,
  }) : super._(
          sender: sender,
          chat: chat,
          owners: owners,
          sentAt: sentAt,
        );

  @override
  LeaveChatServer copyWith({
    int? sender,
    int? chat,
    Object? owners = _Undefined,
    DateTime? sentAt,
  }) {
    return LeaveChatServer(
      sender: sender ?? this.sender,
      chat: chat ?? this.chat,
      owners: owners is List<int>? ? owners : this.owners?.clone(),
      sentAt: sentAt ?? this.sentAt,
    );
  }
}
