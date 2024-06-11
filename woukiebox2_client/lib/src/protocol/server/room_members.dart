/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../protocol.dart' as _i2;

abstract class RoomMembersServer extends _i1.SerializableEntity {
  RoomMembersServer._({required this.users});

  factory RoomMembersServer({required List<_i2.UserServer> users}) =
      _RoomMembersServerImpl;

  factory RoomMembersServer.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return RoomMembersServer(
        users: serializationManager
            .deserialize<List<_i2.UserServer>>(jsonSerialization['users']));
  }

  List<_i2.UserServer> users;

  RoomMembersServer copyWith({List<_i2.UserServer>? users});
  @override
  Map<String, dynamic> toJson() {
    return {'users': users.toJson(valueToJson: (v) => v.toJson())};
  }
}

class _RoomMembersServerImpl extends RoomMembersServer {
  _RoomMembersServerImpl({required List<_i2.UserServer> users})
      : super._(users: users);

  @override
  RoomMembersServer copyWith({List<_i2.UserServer>? users}) {
    return RoomMembersServer(users: users ?? this.users.clone());
  }
}
