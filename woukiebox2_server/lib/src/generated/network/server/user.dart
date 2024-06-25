/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class UserServer extends _i1.SerializableEntity {
  UserServer._({
    required this.id,
    required this.username,
    required this.bio,
    required this.colour,
    required this.image,
    required this.verified,
  });

  factory UserServer({
    required int id,
    required String username,
    required String bio,
    required String colour,
    required String image,
    required bool verified,
  }) = _UserServerImpl;

  factory UserServer.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return UserServer(
      id: serializationManager.deserialize<int>(jsonSerialization['id']),
      username: serializationManager
          .deserialize<String>(jsonSerialization['username']),
      bio: serializationManager.deserialize<String>(jsonSerialization['bio']),
      colour:
          serializationManager.deserialize<String>(jsonSerialization['colour']),
      image:
          serializationManager.deserialize<String>(jsonSerialization['image']),
      verified:
          serializationManager.deserialize<bool>(jsonSerialization['verified']),
    );
  }

  int id;

  String username;

  String bio;

  String colour;

  String image;

  bool verified;

  UserServer copyWith({
    int? id,
    String? username,
    String? bio,
    String? colour,
    String? image,
    bool? verified,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'bio': bio,
      'colour': colour,
      'image': image,
      'verified': verified,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'username': username,
      'bio': bio,
      'colour': colour,
      'image': image,
      'verified': verified,
    };
  }
}

class _UserServerImpl extends UserServer {
  _UserServerImpl({
    required int id,
    required String username,
    required String bio,
    required String colour,
    required String image,
    required bool verified,
  }) : super._(
          id: id,
          username: username,
          bio: bio,
          colour: colour,
          image: image,
          verified: verified,
        );

  @override
  UserServer copyWith({
    int? id,
    String? username,
    String? bio,
    String? colour,
    String? image,
    bool? verified,
  }) {
    return UserServer(
      id: id ?? this.id,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      colour: colour ?? this.colour,
      image: image ?? this.image,
      verified: verified ?? this.verified,
    );
  }
}
