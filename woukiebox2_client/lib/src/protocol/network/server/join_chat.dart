/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../protocol.dart' as _i2;

abstract class JoinChatServer extends _i1.SerializableEntity {
  JoinChatServer._({
    required this.sender,
    required this.chat,
    required this.sentAt,
  });

  factory JoinChatServer({
    required _i2.UserServer sender,
    required int chat,
    required DateTime sentAt,
  }) = _JoinChatServerImpl;

  factory JoinChatServer.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return JoinChatServer(
      sender: serializationManager
          .deserialize<_i2.UserServer>(jsonSerialization['sender']),
      chat: serializationManager.deserialize<int>(jsonSerialization['chat']),
      sentAt: serializationManager
          .deserialize<DateTime>(jsonSerialization['sentAt']),
    );
  }

  _i2.UserServer sender;

  int chat;

  DateTime sentAt;

  JoinChatServer copyWith({
    _i2.UserServer? sender,
    int? chat,
    DateTime? sentAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender.toJson(),
      'chat': chat,
      'sentAt': sentAt.toJson(),
    };
  }
}

class _JoinChatServerImpl extends JoinChatServer {
  _JoinChatServerImpl({
    required _i2.UserServer sender,
    required int chat,
    required DateTime sentAt,
  }) : super._(
          sender: sender,
          chat: chat,
          sentAt: sentAt,
        );

  @override
  JoinChatServer copyWith({
    _i2.UserServer? sender,
    int? chat,
    DateTime? sentAt,
  }) {
    return JoinChatServer(
      sender: sender ?? this.sender.copyWith(),
      chat: chat ?? this.chat,
      sentAt: sentAt ?? this.sentAt,
    );
  }
}
