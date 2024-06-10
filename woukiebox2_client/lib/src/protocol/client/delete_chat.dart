/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class DeleteChatClient extends _i1.SerializableEntity {
  DeleteChatClient._({required this.chat});

  factory DeleteChatClient({required int chat}) = _DeleteChatClientImpl;

  factory DeleteChatClient.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return DeleteChatClient(
        chat: serializationManager.deserialize<int>(jsonSerialization['chat']));
  }

  int chat;

  DeleteChatClient copyWith({int? chat});
  @override
  Map<String, dynamic> toJson() {
    return {'chat': chat};
  }
}

class _DeleteChatClientImpl extends DeleteChatClient {
  _DeleteChatClientImpl({required int chat}) : super._(chat: chat);

  @override
  DeleteChatClient copyWith({int? chat}) {
    return DeleteChatClient(chat: chat ?? this.chat);
  }
}
