/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class ReadChatServer extends _i1.SerializableEntity {
  ReadChatServer._({
    required this.chat,
    required this.readAt,
  });

  factory ReadChatServer({
    required int chat,
    required DateTime readAt,
  }) = _ReadChatServerImpl;

  factory ReadChatServer.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return ReadChatServer(
      chat: serializationManager.deserialize<int>(jsonSerialization['chat']),
      readAt: serializationManager
          .deserialize<DateTime>(jsonSerialization['readAt']),
    );
  }

  int chat;

  DateTime readAt;

  ReadChatServer copyWith({
    int? chat,
    DateTime? readAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'chat': chat,
      'readAt': readAt.toJson(),
    };
  }
}

class _ReadChatServerImpl extends ReadChatServer {
  _ReadChatServerImpl({
    required int chat,
    required DateTime readAt,
  }) : super._(
          chat: chat,
          readAt: readAt,
        );

  @override
  ReadChatServer copyWith({
    int? chat,
    DateTime? readAt,
  }) {
    return ReadChatServer(
      chat: chat ?? this.chat,
      readAt: readAt ?? this.readAt,
    );
  }
}
