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

abstract class JoinMessage extends _i1.SerializableEntity {
  JoinMessage._({required this.user});

  factory JoinMessage({required _i2.User user}) = _JoinMessageImpl;

  factory JoinMessage.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return JoinMessage(
        user: serializationManager
            .deserialize<_i2.User>(jsonSerialization['user']));
  }

  _i2.User user;

  JoinMessage copyWith({_i2.User? user});
  @override
  Map<String, dynamic> toJson() {
    return {'user': user.toJson()};
  }
}

class _JoinMessageImpl extends JoinMessage {
  _JoinMessageImpl({required _i2.User user}) : super._(user: user);

  @override
  JoinMessage copyWith({_i2.User? user}) {
    return JoinMessage(user: user ?? this.user.copyWith());
  }
}
