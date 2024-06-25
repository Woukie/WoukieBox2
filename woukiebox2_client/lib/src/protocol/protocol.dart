/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'chat.dart' as _i2;
import 'last_read.dart' as _i3;
import 'message_type.dart' as _i4;
import 'network/client/create_chat.dart' as _i5;
import 'network/client/friend_update.dart' as _i6;
import 'network/client/read_chat.dart' as _i7;
import 'network/client/update_profile.dart' as _i8;
import 'network/server/chats.dart' as _i9;
import 'network/server/create_chat.dart' as _i10;
import 'network/server/friend_list.dart' as _i11;
import 'network/server/join_chat.dart' as _i12;
import 'network/server/last_read.dart' as _i13;
import 'network/server/read_chat.dart' as _i14;
import 'network/server/room_members.dart' as _i15;
import 'network/server/self_identifier.dart' as _i16;
import 'network/server/update_profile.dart' as _i17;
import 'network/server/user.dart' as _i18;
import 'network/shared/chat_message.dart' as _i19;
import 'user_persistent.dart' as _i20;
import 'protocol.dart' as _i21;
import 'package:woukiebox2_client/src/protocol/chat_message.dart' as _i22;
import 'package:serverpod_auth_client/module.dart' as _i23;
export 'chat.dart';
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
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Map<Type, _i1.constructor> customConstructors = {};

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (customConstructors.containsKey(t)) {
      return customConstructors[t]!(data, this) as T;
    }
    if (t == _i2.Chat) {
      return _i2.Chat.fromJson(data, this) as T;
    }
    if (t == _i3.LastRead) {
      return _i3.LastRead.fromJson(data, this) as T;
    }
    if (t == _i4.MessageType) {
      return _i4.MessageType.fromJson(data) as T;
    }
    if (t == _i5.CreateChatClient) {
      return _i5.CreateChatClient.fromJson(data, this) as T;
    }
    if (t == _i6.FriendRequestClient) {
      return _i6.FriendRequestClient.fromJson(data, this) as T;
    }
    if (t == _i7.ReadChatClient) {
      return _i7.ReadChatClient.fromJson(data, this) as T;
    }
    if (t == _i8.UpdateProfileClient) {
      return _i8.UpdateProfileClient.fromJson(data, this) as T;
    }
    if (t == _i9.ChatsServer) {
      return _i9.ChatsServer.fromJson(data, this) as T;
    }
    if (t == _i10.CreateChatServer) {
      return _i10.CreateChatServer.fromJson(data, this) as T;
    }
    if (t == _i11.FriendListServer) {
      return _i11.FriendListServer.fromJson(data, this) as T;
    }
    if (t == _i12.JoinChatServer) {
      return _i12.JoinChatServer.fromJson(data, this) as T;
    }
    if (t == _i13.LastReadServer) {
      return _i13.LastReadServer.fromJson(data, this) as T;
    }
    if (t == _i14.ReadChatServer) {
      return _i14.ReadChatServer.fromJson(data, this) as T;
    }
    if (t == _i15.RoomMembersServer) {
      return _i15.RoomMembersServer.fromJson(data, this) as T;
    }
    if (t == _i16.SelfIdentifierServer) {
      return _i16.SelfIdentifierServer.fromJson(data, this) as T;
    }
    if (t == _i17.UpdateProfileServer) {
      return _i17.UpdateProfileServer.fromJson(data, this) as T;
    }
    if (t == _i18.UserServer) {
      return _i18.UserServer.fromJson(data, this) as T;
    }
    if (t == _i19.NetworkChatMessage) {
      return _i19.NetworkChatMessage.fromJson(data, this) as T;
    }
    if (t == _i20.UserPersistent) {
      return _i20.UserPersistent.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i2.Chat?>()) {
      return (data != null ? _i2.Chat.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i3.LastRead?>()) {
      return (data != null ? _i3.LastRead.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i4.MessageType?>()) {
      return (data != null ? _i4.MessageType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.CreateChatClient?>()) {
      return (data != null ? _i5.CreateChatClient.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i6.FriendRequestClient?>()) {
      return (data != null
          ? _i6.FriendRequestClient.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i7.ReadChatClient?>()) {
      return (data != null ? _i7.ReadChatClient.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i8.UpdateProfileClient?>()) {
      return (data != null
          ? _i8.UpdateProfileClient.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i9.ChatsServer?>()) {
      return (data != null ? _i9.ChatsServer.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i10.CreateChatServer?>()) {
      return (data != null ? _i10.CreateChatServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i11.FriendListServer?>()) {
      return (data != null ? _i11.FriendListServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i12.JoinChatServer?>()) {
      return (data != null ? _i12.JoinChatServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i13.LastReadServer?>()) {
      return (data != null ? _i13.LastReadServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i14.ReadChatServer?>()) {
      return (data != null ? _i14.ReadChatServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i15.RoomMembersServer?>()) {
      return (data != null ? _i15.RoomMembersServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i16.SelfIdentifierServer?>()) {
      return (data != null
          ? _i16.SelfIdentifierServer.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i17.UpdateProfileServer?>()) {
      return (data != null
          ? _i17.UpdateProfileServer.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i18.UserServer?>()) {
      return (data != null ? _i18.UserServer.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i19.NetworkChatMessage?>()) {
      return (data != null
          ? _i19.NetworkChatMessage.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i20.UserPersistent?>()) {
      return (data != null ? _i20.UserPersistent.fromJson(data, this) : null)
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as dynamic;
    }
    if (t == List<_i21.Chat>) {
      return (data as List).map((e) => deserialize<_i21.Chat>(e)).toList()
          as dynamic;
    }
    if (t == Map<int, DateTime>) {
      return Map.fromEntries((data as List).map((e) => MapEntry(
          deserialize<int>(e['k']), deserialize<DateTime>(e['v'])))) as dynamic;
    }
    if (t == List<_i21.UserServer>) {
      return (data as List).map((e) => deserialize<_i21.UserServer>(e)).toList()
          as dynamic;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toList()
          : null) as dynamic;
    }
    if (t == _i1.getType<List<_i22.ChatMessage>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i22.ChatMessage>(e)).toList()
          : null) as dynamic;
    }
    try {
      return _i23.Protocol().deserialize<T>(data, t);
    } catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    String? className;
    className = _i23.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is _i2.Chat) {
      return 'Chat';
    }
    if (data is _i3.LastRead) {
      return 'LastRead';
    }
    if (data is _i4.MessageType) {
      return 'MessageType';
    }
    if (data is _i5.CreateChatClient) {
      return 'CreateChatClient';
    }
    if (data is _i6.FriendRequestClient) {
      return 'FriendRequestClient';
    }
    if (data is _i7.ReadChatClient) {
      return 'ReadChatClient';
    }
    if (data is _i8.UpdateProfileClient) {
      return 'UpdateProfileClient';
    }
    if (data is _i9.ChatsServer) {
      return 'ChatsServer';
    }
    if (data is _i10.CreateChatServer) {
      return 'CreateChatServer';
    }
    if (data is _i11.FriendListServer) {
      return 'FriendListServer';
    }
    if (data is _i12.JoinChatServer) {
      return 'JoinChatServer';
    }
    if (data is _i13.LastReadServer) {
      return 'LastReadServer';
    }
    if (data is _i14.ReadChatServer) {
      return 'ReadChatServer';
    }
    if (data is _i15.RoomMembersServer) {
      return 'RoomMembersServer';
    }
    if (data is _i16.SelfIdentifierServer) {
      return 'SelfIdentifierServer';
    }
    if (data is _i17.UpdateProfileServer) {
      return 'UpdateProfileServer';
    }
    if (data is _i18.UserServer) {
      return 'UserServer';
    }
    if (data is _i19.NetworkChatMessage) {
      return 'NetworkChatMessage';
    }
    if (data is _i20.UserPersistent) {
      return 'UserPersistent';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'].startsWith('serverpod_auth.')) {
      data['className'] = data['className'].substring(15);
      return _i23.Protocol().deserializeByClassName(data);
    }
    if (data['className'] == 'Chat') {
      return deserialize<_i2.Chat>(data['data']);
    }
    if (data['className'] == 'LastRead') {
      return deserialize<_i3.LastRead>(data['data']);
    }
    if (data['className'] == 'MessageType') {
      return deserialize<_i4.MessageType>(data['data']);
    }
    if (data['className'] == 'CreateChatClient') {
      return deserialize<_i5.CreateChatClient>(data['data']);
    }
    if (data['className'] == 'FriendRequestClient') {
      return deserialize<_i6.FriendRequestClient>(data['data']);
    }
    if (data['className'] == 'ReadChatClient') {
      return deserialize<_i7.ReadChatClient>(data['data']);
    }
    if (data['className'] == 'UpdateProfileClient') {
      return deserialize<_i8.UpdateProfileClient>(data['data']);
    }
    if (data['className'] == 'ChatsServer') {
      return deserialize<_i9.ChatsServer>(data['data']);
    }
    if (data['className'] == 'CreateChatServer') {
      return deserialize<_i10.CreateChatServer>(data['data']);
    }
    if (data['className'] == 'FriendListServer') {
      return deserialize<_i11.FriendListServer>(data['data']);
    }
    if (data['className'] == 'JoinChatServer') {
      return deserialize<_i12.JoinChatServer>(data['data']);
    }
    if (data['className'] == 'LastReadServer') {
      return deserialize<_i13.LastReadServer>(data['data']);
    }
    if (data['className'] == 'ReadChatServer') {
      return deserialize<_i14.ReadChatServer>(data['data']);
    }
    if (data['className'] == 'RoomMembersServer') {
      return deserialize<_i15.RoomMembersServer>(data['data']);
    }
    if (data['className'] == 'SelfIdentifierServer') {
      return deserialize<_i16.SelfIdentifierServer>(data['data']);
    }
    if (data['className'] == 'UpdateProfileServer') {
      return deserialize<_i17.UpdateProfileServer>(data['data']);
    }
    if (data['className'] == 'UserServer') {
      return deserialize<_i18.UserServer>(data['data']);
    }
    if (data['className'] == 'NetworkChatMessage') {
      return deserialize<_i19.NetworkChatMessage>(data['data']);
    }
    if (data['className'] == 'UserPersistent') {
      return deserialize<_i20.UserPersistent>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
