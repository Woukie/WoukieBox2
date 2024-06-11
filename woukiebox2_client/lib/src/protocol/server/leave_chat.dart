/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class LeaveChatServer extends _i1.SerializableEntity {
  LeaveChatServer._({
    required this.sender,
    required this.chat,
    this.owners,
  });

  factory LeaveChatServer({
    required int sender,
    required int chat,
    List<int>? owners,
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
    );
  }

  int sender;

  int chat;

  List<int>? owners;

  LeaveChatServer copyWith({
    int? sender,
    int? chat,
    List<int>? owners,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'chat': chat,
      if (owners != null) 'owners': owners?.toJson(),
    };
  }
}

class _Undefined {}

class _LeaveChatServerImpl extends LeaveChatServer {
  _LeaveChatServerImpl({
    required int sender,
    required int chat,
    List<int>? owners,
  }) : super._(
          sender: sender,
          chat: chat,
          owners: owners,
        );

  @override
  LeaveChatServer copyWith({
    int? sender,
    int? chat,
    Object? owners = _Undefined,
  }) {
    return LeaveChatServer(
      sender: sender ?? this.sender,
      chat: chat ?? this.chat,
      owners: owners is List<int>? ? owners : this.owners?.clone(),
    );
  }
}
