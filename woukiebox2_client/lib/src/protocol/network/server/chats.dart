/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../protocol.dart' as _i2;

abstract class ChatsServer extends _i1.SerializableEntity {
  ChatsServer._({required this.chats});

  factory ChatsServer({required List<_i2.Chat> chats}) = _ChatsServerImpl;

  factory ChatsServer.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return ChatsServer(
        chats: serializationManager
            .deserialize<List<_i2.Chat>>(jsonSerialization['chats']));
  }

  List<_i2.Chat> chats;

  ChatsServer copyWith({List<_i2.Chat>? chats});
  @override
  Map<String, dynamic> toJson() {
    return {'chats': chats.toJson(valueToJson: (v) => v.toJson())};
  }
}

class _ChatsServerImpl extends ChatsServer {
  _ChatsServerImpl({required List<_i2.Chat> chats}) : super._(chats: chats);

  @override
  ChatsServer copyWith({List<_i2.Chat>? chats}) {
    return ChatsServer(chats: chats ?? this.chats.clone());
  }
}
