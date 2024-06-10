/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Chat extends _i1.SerializableEntity {
  Chat._({
    this.id,
    required this.users,
    required this.name,
    required this.owner,
    required this.lastMessage,
  });

  factory Chat({
    int? id,
    required List<int> users,
    required String name,
    required int owner,
    required DateTime lastMessage,
  }) = _ChatImpl;

  factory Chat.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Chat(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      users: serializationManager
          .deserialize<List<int>>(jsonSerialization['users']),
      name: serializationManager.deserialize<String>(jsonSerialization['name']),
      owner: serializationManager.deserialize<int>(jsonSerialization['owner']),
      lastMessage: serializationManager
          .deserialize<DateTime>(jsonSerialization['lastMessage']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  List<int> users;

  String name;

  int owner;

  DateTime lastMessage;

  Chat copyWith({
    int? id,
    List<int>? users,
    String? name,
    int? owner,
    DateTime? lastMessage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'users': users.toJson(),
      'name': name,
      'owner': owner,
      'lastMessage': lastMessage.toJson(),
    };
  }
}

class _Undefined {}

class _ChatImpl extends Chat {
  _ChatImpl({
    int? id,
    required List<int> users,
    required String name,
    required int owner,
    required DateTime lastMessage,
  }) : super._(
          id: id,
          users: users,
          name: name,
          owner: owner,
          lastMessage: lastMessage,
        );

  @override
  Chat copyWith({
    Object? id = _Undefined,
    List<int>? users,
    String? name,
    int? owner,
    DateTime? lastMessage,
  }) {
    return Chat(
      id: id is int? ? id : this.id,
      users: users ?? this.users.clone(),
      name: name ?? this.name,
      owner: owner ?? this.owner,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }
}
