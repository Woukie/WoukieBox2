/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class User extends _i1.SerializableEntity {
  User._({
    required this.id,
    required this.username,
    required this.bio,
    required this.colour,
  });

  factory User({
    required String id,
    required String username,
    required String bio,
    required String colour,
  }) = _UserImpl;

  factory User.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return User(
      id: serializationManager.deserialize<String>(jsonSerialization['id']),
      username: serializationManager
          .deserialize<String>(jsonSerialization['username']),
      bio: serializationManager.deserialize<String>(jsonSerialization['bio']),
      colour:
          serializationManager.deserialize<String>(jsonSerialization['colour']),
    );
  }

  String id;

  String username;

  String bio;

  String colour;

  User copyWith({
    String? id,
    String? username,
    String? bio,
    String? colour,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'bio': bio,
      'colour': colour,
    };
  }
}

class _UserImpl extends User {
  _UserImpl({
    required String id,
    required String username,
    required String bio,
    required String colour,
  }) : super._(
          id: id,
          username: username,
          bio: bio,
          colour: colour,
        );

  @override
  User copyWith({
    String? id,
    String? username,
    String? bio,
    String? colour,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      colour: colour ?? this.colour,
    );
  }
}
