/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../protocol.dart' as _i2;

abstract class CreateChatServer extends _i1.SerializableEntity {
  CreateChatServer._({required this.chat});

  factory CreateChatServer({required _i2.Chat chat}) = _CreateChatServerImpl;

  factory CreateChatServer.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return CreateChatServer(
        chat: serializationManager
            .deserialize<_i2.Chat>(jsonSerialization['chat']));
  }

  _i2.Chat chat;

  CreateChatServer copyWith({_i2.Chat? chat});
  @override
  Map<String, dynamic> toJson() {
    return {'chat': chat.toJson()};
  }

  @override
  Map<String, dynamic> allToJson() {
    return {'chat': chat.allToJson()};
  }
}

class _CreateChatServerImpl extends CreateChatServer {
  _CreateChatServerImpl({required _i2.Chat chat}) : super._(chat: chat);

  @override
  CreateChatServer copyWith({_i2.Chat? chat}) {
    return CreateChatServer(chat: chat ?? this.chat.copyWith());
  }
}
