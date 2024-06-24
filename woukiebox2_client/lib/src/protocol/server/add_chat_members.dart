/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class AddChatMembersServer extends _i1.SerializableEntity {
  AddChatMembersServer._({
    required this.chat,
    required this.sender,
    required this.users,
    required this.sentAt,
  });

  factory AddChatMembersServer({
    required int chat,
    required int sender,
    required List<int> users,
    required DateTime sentAt,
  }) = _AddChatMembersServerImpl;

  factory AddChatMembersServer.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return AddChatMembersServer(
      chat: serializationManager.deserialize<int>(jsonSerialization['chat']),
      sender:
          serializationManager.deserialize<int>(jsonSerialization['sender']),
      users: serializationManager
          .deserialize<List<int>>(jsonSerialization['users']),
      sentAt: serializationManager
          .deserialize<DateTime>(jsonSerialization['sentAt']),
    );
  }

  int chat;

  int sender;

  List<int> users;

  DateTime sentAt;

  AddChatMembersServer copyWith({
    int? chat,
    int? sender,
    List<int>? users,
    DateTime? sentAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'chat': chat,
      'sender': sender,
      'users': users.toJson(),
      'sentAt': sentAt.toJson(),
    };
  }
}

class _AddChatMembersServerImpl extends AddChatMembersServer {
  _AddChatMembersServerImpl({
    required int chat,
    required int sender,
    required List<int> users,
    required DateTime sentAt,
  }) : super._(
          chat: chat,
          sender: sender,
          users: users,
          sentAt: sentAt,
        );

  @override
  AddChatMembersServer copyWith({
    int? chat,
    int? sender,
    List<int>? users,
    DateTime? sentAt,
  }) {
    return AddChatMembersServer(
      chat: chat ?? this.chat,
      sender: sender ?? this.sender,
      users: users ?? this.users.clone(),
      sentAt: sentAt ?? this.sentAt,
    );
  }
}
