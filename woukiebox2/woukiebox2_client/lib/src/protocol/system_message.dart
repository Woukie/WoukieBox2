/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class SystemMessage extends _i1.SerializableEntity {
  SystemMessage._({required this.message});

  factory SystemMessage({required String message}) = _SystemMessageImpl;

  factory SystemMessage.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return SystemMessage(
        message: serializationManager
            .deserialize<String>(jsonSerialization['message']));
  }

  String message;

  SystemMessage copyWith({String? message});
  @override
  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}

class _SystemMessageImpl extends SystemMessage {
  _SystemMessageImpl({required String message}) : super._(message: message);

  @override
  SystemMessage copyWith({String? message}) {
    return SystemMessage(message: message ?? this.message);
  }
}
