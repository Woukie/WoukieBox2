/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class ChatMessageClient extends _i1.SerializableEntity {
  ChatMessageClient._({
    required this.target,
    required this.message,
  });

  factory ChatMessageClient({
    required int target,
    required String message,
  }) = _ChatMessageClientImpl;

  factory ChatMessageClient.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return ChatMessageClient(
      target:
          serializationManager.deserialize<int>(jsonSerialization['target']),
      message: serializationManager
          .deserialize<String>(jsonSerialization['message']),
    );
  }

  int target;

  String message;

  ChatMessageClient copyWith({
    int? target,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'target': target,
      'message': message,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'target': target,
      'message': message,
    };
  }
}

class _ChatMessageClientImpl extends ChatMessageClient {
  _ChatMessageClientImpl({
    required int target,
    required String message,
  }) : super._(
          target: target,
          message: message,
        );

  @override
  ChatMessageClient copyWith({
    int? target,
    String? message,
  }) {
    return ChatMessageClient(
      target: target ?? this.target,
      message: message ?? this.message,
    );
  }
}
