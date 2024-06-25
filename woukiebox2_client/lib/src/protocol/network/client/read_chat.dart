/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class ReadChatClient extends _i1.SerializableEntity {
  ReadChatClient._({required this.chat});

  factory ReadChatClient({required int chat}) = _ReadChatClientImpl;

  factory ReadChatClient.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return ReadChatClient(
        chat: serializationManager.deserialize<int>(jsonSerialization['chat']));
  }

  int chat;

  ReadChatClient copyWith({int? chat});
  @override
  Map<String, dynamic> toJson() {
    return {'chat': chat};
  }
}

class _ReadChatClientImpl extends ReadChatClient {
  _ReadChatClientImpl({required int chat}) : super._(chat: chat);

  @override
  ReadChatClient copyWith({int? chat}) {
    return ReadChatClient(chat: chat ?? this.chat);
  }
}
