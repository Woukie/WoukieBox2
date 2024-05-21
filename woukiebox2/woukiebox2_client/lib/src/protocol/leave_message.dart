/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class LeaveMessage extends _i1.SerializableEntity {
  LeaveMessage._({required this.id});

  factory LeaveMessage({required int id}) = _LeaveMessageImpl;

  factory LeaveMessage.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return LeaveMessage(
        id: serializationManager.deserialize<int>(jsonSerialization['id']));
  }

  int id;

  LeaveMessage copyWith({int? id});
  @override
  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}

class _LeaveMessageImpl extends LeaveMessage {
  _LeaveMessageImpl({required int id}) : super._(id: id);

  @override
  LeaveMessage copyWith({int? id}) {
    return LeaveMessage(id: id ?? this.id);
  }
}
