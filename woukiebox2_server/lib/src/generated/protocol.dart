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
import 'chat_message.dart' as _i5;
import 'last_read.dart' as _i6;
import 'message_type.dart' as _i7;
import 'network/client/create_chat.dart' as _i8;
import 'network/client/friend_update.dart' as _i9;
import 'network/client/read_chat.dart' as _i10;
import 'network/client/update_profile.dart' as _i11;
import 'network/server/chats.dart' as _i12;
import 'network/server/create_chat.dart' as _i13;
import 'network/server/friend_list.dart' as _i14;
import 'network/server/join_chat.dart' as _i15;
import 'network/server/last_read.dart' as _i16;
import 'network/server/read_chat.dart' as _i17;
import 'network/server/room_members.dart' as _i18;
import 'network/server/self_identifier.dart' as _i19;
import 'network/server/update_profile.dart' as _i20;
import 'network/server/user.dart' as _i21;
import 'network/shared/chat_message.dart' as _i22;
import 'user_persistent.dart' as _i23;
import 'protocol.dart' as _i24;
import 'package:woukiebox2_server/src/generated/chat_message.dart' as _i25;
export 'chat.dart';
export 'chat_message.dart';
export 'last_read.dart';
export 'message_type.dart';
export 'network/client/create_chat.dart';
export 'network/client/friend_update.dart';
export 'network/client/read_chat.dart';
export 'network/client/update_profile.dart';
export 'network/server/chats.dart';
export 'network/server/create_chat.dart';
export 'network/server/friend_list.dart';
export 'network/server/join_chat.dart';
export 'network/server/last_read.dart';
export 'network/server/read_chat.dart';
export 'network/server/room_members.dart';
export 'network/server/self_identifier.dart';
export 'network/server/update_profile.dart';
export 'network/server/user.dart';
export 'network/shared/chat_message.dart';
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
          name: 'owners',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<int>',
        ),
        _i2.ColumnDefinition(
          name: 'creator',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'lastMessage',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
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
      name: 'chatmessage',
      dartName: 'ChatMessage',
      schema: 'public',
      module: 'woukiebox2',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'chatmessage_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'sentAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'action',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MessageType',
        ),
        _i2.ColumnDefinition(
          name: 'message',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'targets',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<int>?',
        ),
        _i2.ColumnDefinition(
          name: 'senderId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'chatId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'bucket',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'chatmessage_fk_0',
          columns: ['senderId'],
          referenceTable: 'userpersistent',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'chatmessage_fk_1',
          columns: ['chatId'],
          referenceTable: 'chat',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'chatmessage_pkey',
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
          indexName: 'bucket_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bucket',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'chatmessage_chat_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'chatId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'lastread',
      dartName: 'LastRead',
      schema: 'public',
      module: 'woukiebox2',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'lastread_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userInfoId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'chatId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'readAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'lastread_fk_0',
          columns: ['userInfoId'],
          referenceTable: 'serverpod_user_info',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'lastread_fk_1',
          columns: ['chatId'],
          referenceTable: 'chat',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'lastread_pkey',
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
          indexName: 'lastread_chat_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'chatId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'lastread_user_info_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userInfoId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
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
    if (t == _i5.ChatMessage) {
      return _i5.ChatMessage.fromJson(data, this) as T;
    }
    if (t == _i6.LastRead) {
      return _i6.LastRead.fromJson(data, this) as T;
    }
    if (t == _i7.MessageType) {
      return _i7.MessageType.fromJson(data) as T;
    }
    if (t == _i8.CreateChatClient) {
      return _i8.CreateChatClient.fromJson(data, this) as T;
    }
    if (t == _i9.FriendRequestClient) {
      return _i9.FriendRequestClient.fromJson(data, this) as T;
    }
    if (t == _i10.ReadChatClient) {
      return _i10.ReadChatClient.fromJson(data, this) as T;
    }
    if (t == _i11.UpdateProfileClient) {
      return _i11.UpdateProfileClient.fromJson(data, this) as T;
    }
    if (t == _i12.ChatsServer) {
      return _i12.ChatsServer.fromJson(data, this) as T;
    }
    if (t == _i13.CreateChatServer) {
      return _i13.CreateChatServer.fromJson(data, this) as T;
    }
    if (t == _i14.FriendListServer) {
      return _i14.FriendListServer.fromJson(data, this) as T;
    }
    if (t == _i15.JoinChatServer) {
      return _i15.JoinChatServer.fromJson(data, this) as T;
    }
    if (t == _i16.LastReadServer) {
      return _i16.LastReadServer.fromJson(data, this) as T;
    }
    if (t == _i17.ReadChatServer) {
      return _i17.ReadChatServer.fromJson(data, this) as T;
    }
    if (t == _i18.RoomMembersServer) {
      return _i18.RoomMembersServer.fromJson(data, this) as T;
    }
    if (t == _i19.SelfIdentifierServer) {
      return _i19.SelfIdentifierServer.fromJson(data, this) as T;
    }
    if (t == _i20.UpdateProfileServer) {
      return _i20.UpdateProfileServer.fromJson(data, this) as T;
    }
    if (t == _i21.UserServer) {
      return _i21.UserServer.fromJson(data, this) as T;
    }
    if (t == _i22.NetworkChatMessage) {
      return _i22.NetworkChatMessage.fromJson(data, this) as T;
    }
    if (t == _i23.UserPersistent) {
      return _i23.UserPersistent.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i4.Chat?>()) {
      return (data != null ? _i4.Chat.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i5.ChatMessage?>()) {
      return (data != null ? _i5.ChatMessage.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i6.LastRead?>()) {
      return (data != null ? _i6.LastRead.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i7.MessageType?>()) {
      return (data != null ? _i7.MessageType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.CreateChatClient?>()) {
      return (data != null ? _i8.CreateChatClient.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i9.FriendRequestClient?>()) {
      return (data != null
          ? _i9.FriendRequestClient.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i10.ReadChatClient?>()) {
      return (data != null ? _i10.ReadChatClient.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i11.UpdateProfileClient?>()) {
      return (data != null
          ? _i11.UpdateProfileClient.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i12.ChatsServer?>()) {
      return (data != null ? _i12.ChatsServer.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i13.CreateChatServer?>()) {
      return (data != null ? _i13.CreateChatServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i14.FriendListServer?>()) {
      return (data != null ? _i14.FriendListServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i15.JoinChatServer?>()) {
      return (data != null ? _i15.JoinChatServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i16.LastReadServer?>()) {
      return (data != null ? _i16.LastReadServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i17.ReadChatServer?>()) {
      return (data != null ? _i17.ReadChatServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i18.RoomMembersServer?>()) {
      return (data != null ? _i18.RoomMembersServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i19.SelfIdentifierServer?>()) {
      return (data != null
          ? _i19.SelfIdentifierServer.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i20.UpdateProfileServer?>()) {
      return (data != null
          ? _i20.UpdateProfileServer.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i21.UserServer?>()) {
      return (data != null ? _i21.UserServer.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i22.NetworkChatMessage?>()) {
      return (data != null
          ? _i22.NetworkChatMessage.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i23.UserPersistent?>()) {
      return (data != null ? _i23.UserPersistent.fromJson(data, this) : null)
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as dynamic;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toList()
          : null) as dynamic;
    }
    if (t == List<_i24.Chat>) {
      return (data as List).map((e) => deserialize<_i24.Chat>(e)).toList()
          as dynamic;
    }
    if (t == Map<int, DateTime>) {
      return Map.fromEntries((data as List).map((e) => MapEntry(
          deserialize<int>(e['k']), deserialize<DateTime>(e['v'])))) as dynamic;
    }
    if (t == List<_i24.UserServer>) {
      return (data as List).map((e) => deserialize<_i24.UserServer>(e)).toList()
          as dynamic;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toList()
          : null) as dynamic;
    }
    if (t == _i1.getType<List<_i25.ChatMessage>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i25.ChatMessage>(e)).toList()
          : null) as dynamic;
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
    if (data is _i5.ChatMessage) {
      return 'ChatMessage';
    }
    if (data is _i6.LastRead) {
      return 'LastRead';
    }
    if (data is _i7.MessageType) {
      return 'MessageType';
    }
    if (data is _i8.CreateChatClient) {
      return 'CreateChatClient';
    }
    if (data is _i9.FriendRequestClient) {
      return 'FriendRequestClient';
    }
    if (data is _i10.ReadChatClient) {
      return 'ReadChatClient';
    }
    if (data is _i11.UpdateProfileClient) {
      return 'UpdateProfileClient';
    }
    if (data is _i12.ChatsServer) {
      return 'ChatsServer';
    }
    if (data is _i13.CreateChatServer) {
      return 'CreateChatServer';
    }
    if (data is _i14.FriendListServer) {
      return 'FriendListServer';
    }
    if (data is _i15.JoinChatServer) {
      return 'JoinChatServer';
    }
    if (data is _i16.LastReadServer) {
      return 'LastReadServer';
    }
    if (data is _i17.ReadChatServer) {
      return 'ReadChatServer';
    }
    if (data is _i18.RoomMembersServer) {
      return 'RoomMembersServer';
    }
    if (data is _i19.SelfIdentifierServer) {
      return 'SelfIdentifierServer';
    }
    if (data is _i20.UpdateProfileServer) {
      return 'UpdateProfileServer';
    }
    if (data is _i21.UserServer) {
      return 'UserServer';
    }
    if (data is _i22.NetworkChatMessage) {
      return 'NetworkChatMessage';
    }
    if (data is _i23.UserPersistent) {
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
    if (data['className'] == 'ChatMessage') {
      return deserialize<_i5.ChatMessage>(data['data']);
    }
    if (data['className'] == 'LastRead') {
      return deserialize<_i6.LastRead>(data['data']);
    }
    if (data['className'] == 'MessageType') {
      return deserialize<_i7.MessageType>(data['data']);
    }
    if (data['className'] == 'CreateChatClient') {
      return deserialize<_i8.CreateChatClient>(data['data']);
    }
    if (data['className'] == 'FriendRequestClient') {
      return deserialize<_i9.FriendRequestClient>(data['data']);
    }
    if (data['className'] == 'ReadChatClient') {
      return deserialize<_i10.ReadChatClient>(data['data']);
    }
    if (data['className'] == 'UpdateProfileClient') {
      return deserialize<_i11.UpdateProfileClient>(data['data']);
    }
    if (data['className'] == 'ChatsServer') {
      return deserialize<_i12.ChatsServer>(data['data']);
    }
    if (data['className'] == 'CreateChatServer') {
      return deserialize<_i13.CreateChatServer>(data['data']);
    }
    if (data['className'] == 'FriendListServer') {
      return deserialize<_i14.FriendListServer>(data['data']);
    }
    if (data['className'] == 'JoinChatServer') {
      return deserialize<_i15.JoinChatServer>(data['data']);
    }
    if (data['className'] == 'LastReadServer') {
      return deserialize<_i16.LastReadServer>(data['data']);
    }
    if (data['className'] == 'ReadChatServer') {
      return deserialize<_i17.ReadChatServer>(data['data']);
    }
    if (data['className'] == 'RoomMembersServer') {
      return deserialize<_i18.RoomMembersServer>(data['data']);
    }
    if (data['className'] == 'SelfIdentifierServer') {
      return deserialize<_i19.SelfIdentifierServer>(data['data']);
    }
    if (data['className'] == 'UpdateProfileServer') {
      return deserialize<_i20.UpdateProfileServer>(data['data']);
    }
    if (data['className'] == 'UserServer') {
      return deserialize<_i21.UserServer>(data['data']);
    }
    if (data['className'] == 'NetworkChatMessage') {
      return deserialize<_i22.NetworkChatMessage>(data['data']);
    }
    if (data['className'] == 'UserPersistent') {
      return deserialize<_i23.UserPersistent>(data['data']);
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
      case _i5.ChatMessage:
        return _i5.ChatMessage.t;
      case _i6.LastRead:
        return _i6.LastRead.t;
      case _i23.UserPersistent:
        return _i23.UserPersistent.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'woukiebox2';
}
