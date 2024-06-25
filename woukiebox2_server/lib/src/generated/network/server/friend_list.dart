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

abstract class FriendListServer extends _i1.SerializableEntity {
  FriendListServer._({
    required this.friends,
    required this.outgoingFriendRequests,
    required this.incomingFriendRequests,
  });

  factory FriendListServer({
    required List<int> friends,
    required List<int> outgoingFriendRequests,
    required List<int> incomingFriendRequests,
  }) = _FriendListServerImpl;

  factory FriendListServer.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return FriendListServer(
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

  FriendListServer copyWith({
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

  @override
  Map<String, dynamic> allToJson() {
    return {
      'friends': friends.toJson(),
      'outgoingFriendRequests': outgoingFriendRequests.toJson(),
      'incomingFriendRequests': incomingFriendRequests.toJson(),
    };
  }
}

class _FriendListServerImpl extends FriendListServer {
  _FriendListServerImpl({
    required List<int> friends,
    required List<int> outgoingFriendRequests,
    required List<int> incomingFriendRequests,
  }) : super._(
          friends: friends,
          outgoingFriendRequests: outgoingFriendRequests,
          incomingFriendRequests: incomingFriendRequests,
        );

  @override
  FriendListServer copyWith({
    List<int>? friends,
    List<int>? outgoingFriendRequests,
    List<int>? incomingFriendRequests,
  }) {
    return FriendListServer(
      friends: friends ?? this.friends.clone(),
      outgoingFriendRequests:
          outgoingFriendRequests ?? this.outgoingFriendRequests.clone(),
      incomingFriendRequests:
          incomingFriendRequests ?? this.incomingFriendRequests.clone(),
    );
  }
}
