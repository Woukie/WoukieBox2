/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'protocol.dart' as _i2;

abstract class RoomMembers extends _i1.SerializableEntity {
  RoomMembers._({required this.users});

  factory RoomMembers({required List<_i2.User> users}) = _RoomMembersImpl;

  factory RoomMembers.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return RoomMembers(
        users: serializationManager
            .deserialize<List<_i2.User>>(jsonSerialization['users']));
  }

  List<_i2.User> users;

  RoomMembers copyWith({List<_i2.User>? users});
  @override
  Map<String, dynamic> toJson() {
    return {'users': users.toJson(valueToJson: (v) => v.toJson())};
  }
}

class _RoomMembersImpl extends RoomMembers {
  _RoomMembersImpl({required List<_i2.User> users}) : super._(users: users);

  @override
  RoomMembers copyWith({List<_i2.User>? users}) {
    return RoomMembers(users: users ?? this.users.clone());
  }
}
