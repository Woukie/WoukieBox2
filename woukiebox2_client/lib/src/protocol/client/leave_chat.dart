/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class LeaveChatClient extends _i1.SerializableEntity {
  LeaveChatClient._({required this.chat});

  factory LeaveChatClient({required int chat}) = _LeaveChatClientImpl;

  factory LeaveChatClient.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return LeaveChatClient(
        chat: serializationManager.deserialize<int>(jsonSerialization['chat']));
  }

  int chat;

  LeaveChatClient copyWith({int? chat});
  @override
  Map<String, dynamic> toJson() {
    return {'chat': chat};
  }
}

class _LeaveChatClientImpl extends LeaveChatClient {
  _LeaveChatClientImpl({required int chat}) : super._(chat: chat);

  @override
  LeaveChatClient copyWith({int? chat}) {
    return LeaveChatClient(chat: chat ?? this.chat);
  }
}
