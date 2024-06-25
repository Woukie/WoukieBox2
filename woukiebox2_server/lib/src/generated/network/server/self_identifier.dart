/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class SelfIdentifierServer extends _i1.SerializableEntity {
  SelfIdentifierServer._({required this.id});

  factory SelfIdentifierServer({required int id}) = _SelfIdentifierServerImpl;

  factory SelfIdentifierServer.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return SelfIdentifierServer(
        id: serializationManager.deserialize<int>(jsonSerialization['id']));
  }

  int id;

  SelfIdentifierServer copyWith({int? id});
  @override
  Map<String, dynamic> toJson() {
    return {'id': id};
  }

  @override
  Map<String, dynamic> allToJson() {
    return {'id': id};
  }
}

class _SelfIdentifierServerImpl extends SelfIdentifierServer {
  _SelfIdentifierServerImpl({required int id}) : super._(id: id);

  @override
  SelfIdentifierServer copyWith({int? id}) {
    return SelfIdentifierServer(id: id ?? this.id);
  }
}
