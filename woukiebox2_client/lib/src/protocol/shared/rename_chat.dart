/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class RenameChat extends _i1.SerializableEntity {
  RenameChat._({
    required this.name,
    required this.chat,
  });

  factory RenameChat({
    required String name,
    required int chat,
  }) = _RenameChatImpl;

  factory RenameChat.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return RenameChat(
      name: serializationManager.deserialize<String>(jsonSerialization['name']),
      chat: serializationManager.deserialize<int>(jsonSerialization['chat']),
    );
  }

  String name;

  int chat;

  RenameChat copyWith({
    String? name,
    int? chat,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'chat': chat,
    };
  }
}

class _RenameChatImpl extends RenameChat {
  _RenameChatImpl({
    required String name,
    required int chat,
  }) : super._(
          name: name,
          chat: chat,
        );

  @override
  RenameChat copyWith({
    String? name,
    int? chat,
  }) {
    return RenameChat(
      name: name ?? this.name,
      chat: chat ?? this.chat,
    );
  }
}
