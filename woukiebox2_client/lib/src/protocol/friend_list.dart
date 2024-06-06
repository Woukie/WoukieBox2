/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class FriendList extends _i1.SerializableEntity {
  FriendList._({
    required this.friends,
    required this.outgoingFriendRequests,
    required this.incomingFriendRequests,
  });

  factory FriendList({
    required List<int> friends,
    required List<int> outgoingFriendRequests,
    required List<int> incomingFriendRequests,
  }) = _FriendListImpl;

  factory FriendList.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return FriendList(
      friends: serializationManager
          .deserialize<List<int>>(jsonSerialization['friends']),
      outgoingFriendRequests: serializationManager
          .deserialize<List<int>>(jsonSerialization['outgoingFriendRequests']),
      incomingFriendRequests: serializationManager
          .deserialize<List<int>>(jsonSerialization['incomingFriendRequests']),
    );
  }

  List<int> friends;

  List<int> outgoingFriendRequests;

  List<int> incomingFriendRequests;

  FriendList copyWith({
    List<int>? friends,
    List<int>? outgoingFriendRequests,
    List<int>? incomingFriendRequests,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'friends': friends.toJson(),
      'outgoingFriendRequests': outgoingFriendRequests.toJson(),
      'incomingFriendRequests': incomingFriendRequests.toJson(),
    };
  }
}

class _FriendListImpl extends FriendList {
  _FriendListImpl({
    required List<int> friends,
    required List<int> outgoingFriendRequests,
    required List<int> incomingFriendRequests,
  }) : super._(
          friends: friends,
          outgoingFriendRequests: outgoingFriendRequests,
          incomingFriendRequests: incomingFriendRequests,
        );

  @override
  FriendList copyWith({
    List<int>? friends,
    List<int>? outgoingFriendRequests,
    List<int>? incomingFriendRequests,
  }) {
    return FriendList(
      friends: friends ?? this.friends.clone(),
      outgoingFriendRequests:
          outgoingFriendRequests ?? this.outgoingFriendRequests.clone(),
      incomingFriendRequests:
          incomingFriendRequests ?? this.incomingFriendRequests.clone(),
    );
  }
}
