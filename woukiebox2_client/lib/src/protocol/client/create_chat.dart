/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class CreateChatClient extends _i1.SerializableEntity {
  CreateChatClient._({required this.users});

  factory CreateChatClient({required List<int> users}) = _CreateChatClientImpl;

  factory CreateChatClient.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return CreateChatClient(
        users: serializationManager
            .deserialize<List<int>>(jsonSerialization['users']));
  }

  List<int> users;

  CreateChatClient copyWith({List<int>? users});
  @override
  Map<String, dynamic> toJson() {
    return {'users': users.toJson()};
  }
}

class _CreateChatClientImpl extends CreateChatClient {
  _CreateChatClientImpl({required List<int> users}) : super._(users: users);

  @override
  CreateChatClient copyWith({List<int>? users}) {
    return CreateChatClient(users: users ?? this.users.clone());
  }
}
