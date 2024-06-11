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

abstract class CreateChatClient extends _i1.SerializableEntity {
  CreateChatClient._({
    required this.users,
    required this.owners,
    required this.name,
  });

  factory CreateChatClient({
    required List<int> users,
    required List<int> owners,
    required String name,
  }) = _CreateChatClientImpl;

  factory CreateChatClient.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return CreateChatClient(
      users: serializationManager
          .deserialize<List<int>>(jsonSerialization['users']),
      owners: serializationManager
          .deserialize<List<int>>(jsonSerialization['owners']),
      name: serializationManager.deserialize<String>(jsonSerialization['name']),
    );
  }

  List<int> users;

  List<int> owners;

  String name;

  CreateChatClient copyWith({
    List<int>? users,
    List<int>? owners,
    String? name,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'users': users.toJson(),
      'owners': owners.toJson(),
      'name': name,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'users': users.toJson(),
      'owners': owners.toJson(),
      'name': name,
    };
  }
}

class _CreateChatClientImpl extends CreateChatClient {
  _CreateChatClientImpl({
    required List<int> users,
    required List<int> owners,
    required String name,
  }) : super._(
          users: users,
          owners: owners,
          name: name,
        );

  @override
  CreateChatClient copyWith({
    List<int>? users,
    List<int>? owners,
    String? name,
  }) {
    return CreateChatClient(
      users: users ?? this.users.clone(),
      owners: owners ?? this.owners.clone(),
      name: name ?? this.name,
    );
  }
}
