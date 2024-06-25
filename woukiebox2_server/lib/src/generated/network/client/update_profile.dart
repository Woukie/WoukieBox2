/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class UpdateProfileClient extends _i1.SerializableEntity {
  UpdateProfileClient._({
    this.username,
    this.bio,
    this.colour,
    this.image,
  });

  factory UpdateProfileClient({
    String? username,
    String? bio,
    String? colour,
    String? image,
  }) = _UpdateProfileClientImpl;

  factory UpdateProfileClient.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return UpdateProfileClient(
      username: serializationManager
          .deserialize<String?>(jsonSerialization['username']),
      bio: serializationManager.deserialize<String?>(jsonSerialization['bio']),
      colour: serializationManager
          .deserialize<String?>(jsonSerialization['colour']),
      image:
          serializationManager.deserialize<String?>(jsonSerialization['image']),
    );
  }

  String? username;

  String? bio;

  String? colour;

  String? image;

  UpdateProfileClient copyWith({
    String? username,
    String? bio,
    String? colour,
    String? image,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (username != null) 'username': username,
      if (bio != null) 'bio': bio,
      if (colour != null) 'colour': colour,
      if (image != null) 'image': image,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (username != null) 'username': username,
      if (bio != null) 'bio': bio,
      if (colour != null) 'colour': colour,
      if (image != null) 'image': image,
    };
  }
}

class _Undefined {}

class _UpdateProfileClientImpl extends UpdateProfileClient {
  _UpdateProfileClientImpl({
    String? username,
    String? bio,
    String? colour,
    String? image,
  }) : super._(
          username: username,
          bio: bio,
          colour: colour,
          image: image,
        );

  @override
  UpdateProfileClient copyWith({
    Object? username = _Undefined,
    Object? bio = _Undefined,
    Object? colour = _Undefined,
    Object? image = _Undefined,
  }) {
    return UpdateProfileClient(
      username: username is String? ? username : this.username,
      bio: bio is String? ? bio : this.bio,
      colour: colour is String? ? colour : this.colour,
      image: image is String? ? image : this.image,
    );
  }
}
