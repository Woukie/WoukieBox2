/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'package:serverpod_auth_client/module.dart' as _i2;
import 'protocol.dart' as _i3;

abstract class LastRead extends _i1.SerializableEntity {
  LastRead._({
    this.id,
    required this.userInfoId,
    this.userInfo,
    required this.chatId,
    this.chat,
    required this.readAt,
  });

  factory LastRead({
    int? id,
    required int userInfoId,
    _i2.UserInfo? userInfo,
    required int chatId,
    _i3.Chat? chat,
    required DateTime readAt,
  }) = _LastReadImpl;

  factory LastRead.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return LastRead(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      userInfoId: serializationManager
          .deserialize<int>(jsonSerialization['userInfoId']),
      userInfo: serializationManager
          .deserialize<_i2.UserInfo?>(jsonSerialization['userInfo']),
      chatId:
          serializationManager.deserialize<int>(jsonSerialization['chatId']),
      chat: serializationManager
          .deserialize<_i3.Chat?>(jsonSerialization['chat']),
      readAt: serializationManager
          .deserialize<DateTime>(jsonSerialization['readAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userInfoId;

  _i2.UserInfo? userInfo;

  int chatId;

  _i3.Chat? chat;

  DateTime readAt;

  LastRead copyWith({
    int? id,
    int? userInfoId,
    _i2.UserInfo? userInfo,
    int? chatId,
    _i3.Chat? chat,
    DateTime? readAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userInfoId': userInfoId,
      if (userInfo != null) 'userInfo': userInfo?.toJson(),
      'chatId': chatId,
      if (chat != null) 'chat': chat?.toJson(),
      'readAt': readAt.toJson(),
    };
  }
}

class _Undefined {}

class _LastReadImpl extends LastRead {
  _LastReadImpl({
    int? id,
    required int userInfoId,
    _i2.UserInfo? userInfo,
    required int chatId,
    _i3.Chat? chat,
    required DateTime readAt,
  }) : super._(
          id: id,
          userInfoId: userInfoId,
          userInfo: userInfo,
          chatId: chatId,
          chat: chat,
          readAt: readAt,
        );

  @override
  LastRead copyWith({
    Object? id = _Undefined,
    int? userInfoId,
    Object? userInfo = _Undefined,
    int? chatId,
    Object? chat = _Undefined,
    DateTime? readAt,
  }) {
    return LastRead(
      id: id is int? ? id : this.id,
      userInfoId: userInfoId ?? this.userInfoId,
      userInfo:
          userInfo is _i2.UserInfo? ? userInfo : this.userInfo?.copyWith(),
      chatId: chatId ?? this.chatId,
      chat: chat is _i3.Chat? ? chat : this.chat?.copyWith(),
      readAt: readAt ?? this.readAt,
    );
  }
}
