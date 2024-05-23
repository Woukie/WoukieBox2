/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class UpdateProfile extends _i1.SerializableEntity {
  UpdateProfile._({
    this.sender,
    this.username,
    this.bio,
    this.colour,
  });

  factory UpdateProfile({
    int? sender,
    String? username,
    String? bio,
    String? colour,
  }) = _UpdateProfileImpl;

  factory UpdateProfile.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return UpdateProfile(
      sender:
          serializationManager.deserialize<int?>(jsonSerialization['sender']),
      username: serializationManager
          .deserialize<String?>(jsonSerialization['username']),
      bio: serializationManager.deserialize<String?>(jsonSerialization['bio']),
      colour: serializationManager
          .deserialize<String?>(jsonSerialization['colour']),
    );
  }

  int? sender;

  String? username;

  String? bio;

  String? colour;

  UpdateProfile copyWith({
    int? sender,
    String? username,
    String? bio,
    String? colour,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (sender != null) 'sender': sender,
      if (username != null) 'username': username,
      if (bio != null) 'bio': bio,
      if (colour != null) 'colour': colour,
    };
  }
}

class _Undefined {}

class _UpdateProfileImpl extends UpdateProfile {
  _UpdateProfileImpl({
    int? sender,
    String? username,
    String? bio,
    String? colour,
  }) : super._(
          sender: sender,
          username: username,
          bio: bio,
          colour: colour,
        );

  @override
  UpdateProfile copyWith({
    Object? sender = _Undefined,
    Object? username = _Undefined,
    Object? bio = _Undefined,
    Object? colour = _Undefined,
  }) {
    return UpdateProfile(
      sender: sender is int? ? sender : this.sender,
      username: username is String? ? username : this.username,
      bio: bio is String? ? bio : this.bio,
      colour: colour is String? ? colour : this.colour,
    );
  }
}