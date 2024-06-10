/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod_serialization/serverpod_serialization.dart';

abstract class ChatsServer extends _i1.SerializableEntity {
  ChatsServer._({required this.chats});

  factory ChatsServer({required List<int> chats}) = _ChatsServerImpl;

  factory ChatsServer.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return ChatsServer(
        chats: serializationManager
            .deserialize<List<int>>(jsonSerialization['chats']));
  }

  List<int> chats;

  ChatsServer copyWith({List<int>? chats});
  @override
  Map<String, dynamic> toJson() {
    return {'chats': chats.toJson()};
  }

  @override
  Map<String, dynamic> allToJson() {
    return {'chats': chats.toJson()};
  }
}

class _ChatsServerImpl extends ChatsServer {
  _ChatsServerImpl({required List<int> chats}) : super._(chats: chats);

  @override
  ChatsServer copyWith({List<int>? chats}) {
    return ChatsServer(chats: chats ?? this.chats.clone());
  }
}
