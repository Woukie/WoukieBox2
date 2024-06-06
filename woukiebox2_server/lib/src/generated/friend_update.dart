/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class FriendRequest extends _i1.SerializableEntity {
  FriendRequest._({
    this.sender,
    required this.target,
    required this.positive,
  });

  factory FriendRequest({
    int? sender,
    required int target,
    required bool positive,
  }) = _FriendRequestImpl;

  factory FriendRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return FriendRequest(
      sender:
          serializationManager.deserialize<int?>(jsonSerialization['sender']),
      target:
          serializationManager.deserialize<int>(jsonSerialization['target']),
      positive:
          serializationManager.deserialize<bool>(jsonSerialization['positive']),
    );
  }

  int? sender;

  int target;

  bool positive;

  FriendRequest copyWith({
    int? sender,
    int? target,
    bool? positive,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (sender != null) 'sender': sender,
      'target': target,
      'positive': positive,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (sender != null) 'sender': sender,
      'target': target,
      'positive': positive,
    };
  }
}

class _Undefined {}

class _FriendRequestImpl extends FriendRequest {
  _FriendRequestImpl({
    int? sender,
    required int target,
    required bool positive,
  }) : super._(
          sender: sender,
          target: target,
          positive: positive,
        );

  @override
  FriendRequest copyWith({
    Object? sender = _Undefined,
    int? target,
    bool? positive,
  }) {
    return FriendRequest(
      sender: sender is int? ? sender : this.sender,
      target: target ?? this.target,
      positive: positive ?? this.positive,
    );
  }
}
