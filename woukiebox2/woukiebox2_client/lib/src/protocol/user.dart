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
    required this.verified,
  });

  factory User({
    required int id,
    required String username,
    required String bio,
    required String colour,
    required bool verified,
  }) = _UserImpl;

  factory User.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return User(
      id: serializationManager.deserialize<int>(jsonSerialization['id']),
      username: serializationManager
          .deserialize<String>(jsonSerialization['username']),
      bio: serializationManager.deserialize<String>(jsonSerialization['bio']),
      colour:
          serializationManager.deserialize<String>(jsonSerialization['colour']),
      verified:
          serializationManager.deserialize<bool>(jsonSerialization['verified']),
    );
  }

  int id;

  String username;

  String bio;

  String colour;

  bool verified;

  User copyWith({
    int? id,
    String? username,
    String? bio,
    String? colour,
    bool? verified,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'bio': bio,
      'colour': colour,
      'verified': verified,
    };
  }
}

class _UserImpl extends User {
  _UserImpl({
    required int id,
    required String username,
    required String bio,
    required String colour,
    required bool verified,
  }) : super._(
          id: id,
          username: username,
          bio: bio,
          colour: colour,
          verified: verified,
        );

  @override
  User copyWith({
    int? id,
    String? username,
    String? bio,
    String? colour,
    bool? verified,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      colour: colour ?? this.colour,
      verified: verified ?? this.verified,
    );
  }
}