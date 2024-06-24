/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class PromoteChatMemberClient extends _i1.SerializableEntity {
  PromoteChatMemberClient._({
    required this.user,
    required this.chat,
  });

  factory PromoteChatMemberClient({
    required int user,
    required int chat,
  }) = _PromoteChatMemberClientImpl;

  factory PromoteChatMemberClient.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return PromoteChatMemberClient(
      user: serializationManager.deserialize<int>(jsonSerialization['user']),
      chat: serializationManager.deserialize<int>(jsonSerialization['chat']),
    );
  }

  int user;

  int chat;

  PromoteChatMemberClient copyWith({
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

class _PromoteChatMemberClientImpl extends PromoteChatMemberClient {
  _PromoteChatMemberClientImpl({
    required int user,
    required int chat,
  }) : super._(
          user: user,
          chat: chat,
        );

  @override
  PromoteChatMemberClient copyWith({
    int? user,
    int? chat,
  }) {
    return PromoteChatMemberClient(
      user: user ?? this.user,
      chat: chat ?? this.chat,
    );
  }
}
