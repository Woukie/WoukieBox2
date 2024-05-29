/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'package:serverpod_auth_client/module.dart' as _i2;

abstract class UserPersistent extends _i1.SerializableEntity {
  UserPersistent._({
    this.id,
    required this.userInfoId,
    this.userInfo,
    required this.color,
    required this.bio,
    required this.image,
  });

  factory UserPersistent({
    int? id,
    required int userInfoId,
    _i2.UserInfo? userInfo,
    required String color,
    required String bio,
    required String image,
  }) = _UserPersistentImpl;

  factory UserPersistent.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return UserPersistent(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      userInfoId: serializationManager
          .deserialize<int>(jsonSerialization['userInfoId']),
      userInfo: serializationManager
          .deserialize<_i2.UserInfo?>(jsonSerialization['userInfo']),
      color:
          serializationManager.deserialize<String>(jsonSerialization['color']),
      bio: serializationManager.deserialize<String>(jsonSerialization['bio']),
      image:
          serializationManager.deserialize<String>(jsonSerialization['image']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userInfoId;

  _i2.UserInfo? userInfo;

  String color;

  String bio;

  String image;

  UserPersistent copyWith({
    int? id,
    int? userInfoId,
    _i2.UserInfo? userInfo,
    String? color,
    String? bio,
    String? image,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userInfoId': userInfoId,
      if (userInfo != null) 'userInfo': userInfo?.toJson(),
      'color': color,
      'bio': bio,
      'image': image,
    };
  }
}

class _Undefined {}

class _UserPersistentImpl extends UserPersistent {
  _UserPersistentImpl({
    int? id,
    required int userInfoId,
    _i2.UserInfo? userInfo,
    required String color,
    required String bio,
    required String image,
  }) : super._(
          id: id,
          userInfoId: userInfoId,
          userInfo: userInfo,
          color: color,
          bio: bio,
          image: image,
        );

  @override
  UserPersistent copyWith({
    Object? id = _Undefined,
    int? userInfoId,
    Object? userInfo = _Undefined,
    String? color,
    String? bio,
    String? image,
  }) {
    return UserPersistent(
      id: id is int? ? id : this.id,
      userInfoId: userInfoId ?? this.userInfoId,
      userInfo:
          userInfo is _i2.UserInfo? ? userInfo : this.userInfo?.copyWith(),
      color: color ?? this.color,
      bio: bio ?? this.bio,
      image: image ?? this.image,
    );
  }
}
