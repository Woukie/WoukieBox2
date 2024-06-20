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

abstract class AddChatMembersClient extends _i1.SerializableEntity {
  AddChatMembersClient._({
    required this.users,
    required this.chat,
  });

  factory AddChatMembersClient({
    required List<int> users,
    required int chat,
  }) = _AddChatMembersClientImpl;

  factory AddChatMembersClient.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return AddChatMembersClient(
      users: serializationManager
          .deserialize<List<int>>(jsonSerialization['users']),
      chat: serializationManager.deserialize<int>(jsonSerialization['chat']),
    );
  }

  List<int> users;

  int chat;

  AddChatMembersClient copyWith({
    List<int>? users,
    int? chat,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'users': users.toJson(),
      'chat': chat,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'users': users.toJson(),
      'chat': chat,
    };
  }
}

class _AddChatMembersClientImpl extends AddChatMembersClient {
  _AddChatMembersClientImpl({
    required List<int> users,
    required int chat,
  }) : super._(
          users: users,
          chat: chat,
        );

  @override
  AddChatMembersClient copyWith({
    List<int>? users,
    int? chat,
  }) {
    return AddChatMembersClient(
      users: users ?? this.users.clone(),
      chat: chat ?? this.chat,
    );
  }
}
