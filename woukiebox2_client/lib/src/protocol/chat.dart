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
    required this.owners,
    required this.creator,
    required this.name,
    required this.lastMessage,
  });

  factory Chat({
    int? id,
    required List<int> users,
    required List<int> owners,
    required int creator,
    required String name,
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
      owners: serializationManager
          .deserialize<List<int>>(jsonSerialization['owners']),
      creator:
          serializationManager.deserialize<int>(jsonSerialization['creator']),
      name: serializationManager.deserialize<String>(jsonSerialization['name']),
      lastMessage: serializationManager
          .deserialize<DateTime>(jsonSerialization['lastMessage']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  List<int> users;

  List<int> owners;

  int creator;

  String name;

  DateTime lastMessage;

  Chat copyWith({
    int? id,
    List<int>? users,
    List<int>? owners,
    int? creator,
    String? name,
    DateTime? lastMessage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'users': users.toJson(),
      'owners': owners.toJson(),
      'creator': creator,
      'name': name,
      'lastMessage': lastMessage.toJson(),
    };
  }
}

class _Undefined {}

class _ChatImpl extends Chat {
  _ChatImpl({
    int? id,
    required List<int> users,
    required List<int> owners,
    required int creator,
    required String name,
    required DateTime lastMessage,
  }) : super._(
          id: id,
          users: users,
          owners: owners,
          creator: creator,
          name: name,
          lastMessage: lastMessage,
        );

  @override
  Chat copyWith({
    Object? id = _Undefined,
    List<int>? users,
    List<int>? owners,
    int? creator,
    String? name,
    DateTime? lastMessage,
  }) {
    return Chat(
      id: id is int? ? id : this.id,
      users: users ?? this.users.clone(),
      owners: owners ?? this.owners.clone(),
      creator: creator ?? this.creator,
      name: name ?? this.name,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }
}
