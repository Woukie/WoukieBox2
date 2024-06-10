/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_server/module.dart' as _i3;
import 'chat.dart' as _i4;
import 'client/chat_message.dart' as _i5;
import 'client/create_chat.dart' as _i6;
import 'client/delete_chat.dart' as _i7;
import 'client/friend_update.dart' as _i8;
import 'client/leave_chat.dart' as _i9;
import 'client/update_profile.dart' as _i10;
import 'client/user.dart' as _i11;
import 'server/chat_message.dart' as _i12;
import 'server/chats.dart' as _i13;
import 'server/friend_list.dart' as _i14;
import 'server/join_chat.dart' as _i15;
import 'server/leave_chat.dart' as _i16;
import 'server/room_members.dart' as _i17;
import 'server/self_identifier.dart' as _i18;
import 'server/update_profile.dart' as _i19;
import 'server/user.dart' as _i20;
import 'user_persistent.dart' as _i21;
import 'protocol.dart' as _i22;
export 'chat.dart';
export 'client/chat_message.dart';
export 'client/create_chat.dart';
export 'client/delete_chat.dart';
export 'client/friend_update.dart';
export 'client/leave_chat.dart';
export 'client/update_profile.dart';
export 'client/user.dart';
export 'server/chat_message.dart';
export 'server/chats.dart';
export 'server/friend_list.dart';
export 'server/join_chat.dart';
export 'server/leave_chat.dart';
export 'server/room_members.dart';
export 'server/self_identifier.dart';
export 'server/update_profile.dart';
export 'server/user.dart';
export 'user_persistent.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Map<Type, _i1.constructor> customConstructors = {};

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'chat',
      dartName: 'Chat',
      schema: 'public',
      module: 'woukiebox2',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'chat_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'users',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<int>',
        ),
        _i2.ColumnDefinition(
          name: 'owner',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'chat_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'userpersistent',
      dartName: 'UserPersistent',
      schema: 'public',
      module: 'woukiebox2',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'userpersistent_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userInfoId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'color',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'bio',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'image',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'chats',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<int>',
        ),
        _i2.ColumnDefinition(
          name: 'friends',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<int>',
        ),
        _i2.ColumnDefinition(
          name: 'outgoingFriendRequests',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<int>',
        ),
        _i2.ColumnDefinition(
          name: 'incomingFriendRequests',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<int>',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'userpersistent_fk_0',
          columns: ['userInfoId'],
          referenceTable: 'serverpod_user_info',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'userpersistent_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'user_info_id_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userInfoId',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (customConstructors.containsKey(t)) {
      return customConstructors[t]!(data, this) as T;
    }
    if (t == _i4.Chat) {
      return _i4.Chat.fromJson(data, this) as T;
    }
    if (t == _i5.ChatMessageClient) {
      return _i5.ChatMessageClient.fromJson(data, this) as T;
    }
    if (t == _i6.CreateChatClient) {
      return _i6.CreateChatClient.fromJson(data, this) as T;
    }
    if (t == _i7.DeleteChatClient) {
      return _i7.DeleteChatClient.fromJson(data, this) as T;
    }
    if (t == _i8.FriendRequestClient) {
      return _i8.FriendRequestClient.fromJson(data, this) as T;
    }
    if (t == _i9.LeaveChatClient) {
      return _i9.LeaveChatClient.fromJson(data, this) as T;
    }
    if (t == _i10.UpdateProfileClient) {
      return _i10.UpdateProfileClient.fromJson(data, this) as T;
    }
    if (t == _i11.UserClient) {
      return _i11.UserClient.fromJson(data, this) as T;
    }
    if (t == _i12.ChatMessageServer) {
      return _i12.ChatMessageServer.fromJson(data, this) as T;
    }
    if (t == _i13.ChatsServer) {
      return _i13.ChatsServer.fromJson(data, this) as T;
    }
    if (t == _i14.FriendListServer) {
      return _i14.FriendListServer.fromJson(data, this) as T;
    }
    if (t == _i15.JoinChatServer) {
      return _i15.JoinChatServer.fromJson(data, this) as T;
    }
    if (t == _i16.LeaveChatServer) {
      return _i16.LeaveChatServer.fromJson(data, this) as T;
    }
    if (t == _i17.RoomMembersServer) {
      return _i17.RoomMembersServer.fromJson(data, this) as T;
    }
    if (t == _i18.SelfIdentifierServer) {
      return _i18.SelfIdentifierServer.fromJson(data, this) as T;
    }
    if (t == _i19.UpdateProfileServer) {
      return _i19.UpdateProfileServer.fromJson(data, this) as T;
    }
    if (t == _i20.UserServer) {
      return _i20.UserServer.fromJson(data, this) as T;
    }
    if (t == _i21.UserPersistent) {
      return _i21.UserPersistent.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i4.Chat?>()) {
      return (data != null ? _i4.Chat.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i5.ChatMessageClient?>()) {
      return (data != null ? _i5.ChatMessageClient.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i6.CreateChatClient?>()) {
      return (data != null ? _i6.CreateChatClient.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i7.DeleteChatClient?>()) {
      return (data != null ? _i7.DeleteChatClient.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i8.FriendRequestClient?>()) {
      return (data != null
          ? _i8.FriendRequestClient.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i9.LeaveChatClient?>()) {
      return (data != null ? _i9.LeaveChatClient.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i10.UpdateProfileClient?>()) {
      return (data != null
          ? _i10.UpdateProfileClient.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i11.UserClient?>()) {
      return (data != null ? _i11.UserClient.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i12.ChatMessageServer?>()) {
      return (data != null ? _i12.ChatMessageServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i13.ChatsServer?>()) {
      return (data != null ? _i13.ChatsServer.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i14.FriendListServer?>()) {
      return (data != null ? _i14.FriendListServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i15.JoinChatServer?>()) {
      return (data != null ? _i15.JoinChatServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i16.LeaveChatServer?>()) {
      return (data != null ? _i16.LeaveChatServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i17.RoomMembersServer?>()) {
      return (data != null ? _i17.RoomMembersServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i18.SelfIdentifierServer?>()) {
      return (data != null
          ? _i18.SelfIdentifierServer.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i19.UpdateProfileServer?>()) {
      return (data != null
          ? _i19.UpdateProfileServer.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i20.UserServer?>()) {
      return (data != null ? _i20.UserServer.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i21.UserPersistent?>()) {
      return (data != null ? _i21.UserPersistent.fromJson(data, this) : null)
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as dynamic;
    }
    if (t == List<_i22.UserServer>) {
      return (data as List).map((e) => deserialize<_i22.UserServer>(e)).toList()
          as dynamic;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    String? className;
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is _i4.Chat) {
      return 'Chat';
    }
    if (data is _i5.ChatMessageClient) {
      return 'ChatMessageClient';
    }
    if (data is _i6.CreateChatClient) {
      return 'CreateChatClient';
    }
    if (data is _i7.DeleteChatClient) {
      return 'DeleteChatClient';
    }
    if (data is _i8.FriendRequestClient) {
      return 'FriendRequestClient';
    }
    if (data is _i9.LeaveChatClient) {
      return 'LeaveChatClient';
    }
    if (data is _i10.UpdateProfileClient) {
      return 'UpdateProfileClient';
    }
    if (data is _i11.UserClient) {
      return 'UserClient';
    }
    if (data is _i12.ChatMessageServer) {
      return 'ChatMessageServer';
    }
    if (data is _i13.ChatsServer) {
      return 'ChatsServer';
    }
    if (data is _i14.FriendListServer) {
      return 'FriendListServer';
    }
    if (data is _i15.JoinChatServer) {
      return 'JoinChatServer';
    }
    if (data is _i16.LeaveChatServer) {
      return 'LeaveChatServer';
    }
    if (data is _i17.RoomMembersServer) {
      return 'RoomMembersServer';
    }
    if (data is _i18.SelfIdentifierServer) {
      return 'SelfIdentifierServer';
    }
    if (data is _i19.UpdateProfileServer) {
      return 'UpdateProfileServer';
    }
    if (data is _i20.UserServer) {
      return 'UserServer';
    }
    if (data is _i21.UserPersistent) {
      return 'UserPersistent';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'].startsWith('serverpod_auth.')) {
      data['className'] = data['className'].substring(15);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (data['className'] == 'Chat') {
      return deserialize<_i4.Chat>(data['data']);
    }
    if (data['className'] == 'ChatMessageClient') {
      return deserialize<_i5.ChatMessageClient>(data['data']);
    }
    if (data['className'] == 'CreateChatClient') {
      return deserialize<_i6.CreateChatClient>(data['data']);
    }
    if (data['className'] == 'DeleteChatClient') {
      return deserialize<_i7.DeleteChatClient>(data['data']);
    }
    if (data['className'] == 'FriendRequestClient') {
      return deserialize<_i8.FriendRequestClient>(data['data']);
    }
    if (data['className'] == 'LeaveChatClient') {
      return deserialize<_i9.LeaveChatClient>(data['data']);
    }
    if (data['className'] == 'UpdateProfileClient') {
      return deserialize<_i10.UpdateProfileClient>(data['data']);
    }
    if (data['className'] == 'UserClient') {
      return deserialize<_i11.UserClient>(data['data']);
    }
    if (data['className'] == 'ChatMessageServer') {
      return deserialize<_i12.ChatMessageServer>(data['data']);
    }
    if (data['className'] == 'ChatsServer') {
      return deserialize<_i13.ChatsServer>(data['data']);
    }
    if (data['className'] == 'FriendListServer') {
      return deserialize<_i14.FriendListServer>(data['data']);
    }
    if (data['className'] == 'JoinChatServer') {
      return deserialize<_i15.JoinChatServer>(data['data']);
    }
    if (data['className'] == 'LeaveChatServer') {
      return deserialize<_i16.LeaveChatServer>(data['data']);
    }
    if (data['className'] == 'RoomMembersServer') {
      return deserialize<_i17.RoomMembersServer>(data['data']);
    }
    if (data['className'] == 'SelfIdentifierServer') {
      return deserialize<_i18.SelfIdentifierServer>(data['data']);
    }
    if (data['className'] == 'UpdateProfileServer') {
      return deserialize<_i19.UpdateProfileServer>(data['data']);
    }
    if (data['className'] == 'UserServer') {
      return deserialize<_i20.UserServer>(data['data']);
    }
    if (data['className'] == 'UserPersistent') {
      return deserialize<_i21.UserPersistent>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i4.Chat:
        return _i4.Chat.t;
      case _i21.UserPersistent:
        return _i21.UserPersistent.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'woukiebox2';
}
