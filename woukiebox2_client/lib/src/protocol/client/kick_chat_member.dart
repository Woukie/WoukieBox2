/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class KickChatMemberClient extends _i1.SerializableEntity {
  KickChatMemberClient._({
    required this.user,
    required this.chat,
  });

  factory KickChatMemberClient({
    required int user,
    required int chat,
  }) = _KickChatMemberClientImpl;

  factory KickChatMemberClient.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return KickChatMemberClient(
      user: serializationManager.deserialize<int>(jsonSerialization['user']),
      chat: serializationManager.deserialize<int>(jsonSerialization['chat']),
    );
  }

  int user;

  int chat;

  KickChatMemberClient copyWith({
    int? user,
    int? chat,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'chat': chat,
    };
  }
}

class _KickChatMemberClientImpl extends KickChatMemberClient {
  _KickChatMemberClientImpl({
    required int user,
    required int chat,
  }) : super._(
          user: user,
          chat: chat,
        );

  @override
  KickChatMemberClient copyWith({
    int? user,
    int? chat,
  }) {
    return KickChatMemberClient(
      user: user ?? this.user,
      chat: chat ?? this.chat,
    );
  }
}
