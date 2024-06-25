/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class FriendRequestClient extends _i1.SerializableEntity {
  FriendRequestClient._({
    required this.target,
    required this.positive,
  });

  factory FriendRequestClient({
    required int target,
    required bool positive,
  }) = _FriendRequestClientImpl;

  factory FriendRequestClient.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return FriendRequestClient(
      target:
          serializationManager.deserialize<int>(jsonSerialization['target']),
      positive:
          serializationManager.deserialize<bool>(jsonSerialization['positive']),
    );
  }

  int target;

  bool positive;

  FriendRequestClient copyWith({
    int? target,
    bool? positive,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'target': target,
      'positive': positive,
    };
  }
}

class _FriendRequestClientImpl extends FriendRequestClient {
  _FriendRequestClientImpl({
    required int target,
    required bool positive,
  }) : super._(
          target: target,
          positive: positive,
        );

  @override
  FriendRequestClient copyWith({
    int? target,
    bool? positive,
  }) {
    return FriendRequestClient(
      target: target ?? this.target,
      positive: positive ?? this.positive,
    );
  }
}
