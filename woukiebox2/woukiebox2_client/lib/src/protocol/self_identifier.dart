/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class SelfIdentifier extends _i1.SerializableEntity {
  SelfIdentifier._({required this.id});

  factory SelfIdentifier({required int id}) = _SelfIdentifierImpl;

  factory SelfIdentifier.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return SelfIdentifier(
        id: serializationManager.deserialize<int>(jsonSerialization['id']));
  }

  int id;

  SelfIdentifier copyWith({int? id});
  @override
  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}

class _SelfIdentifierImpl extends SelfIdentifier {
  _SelfIdentifierImpl({required int id}) : super._(id: id);

  @override
  SelfIdentifier copyWith({int? id}) {
    return SelfIdentifier(id: id ?? this.id);
  }
}
