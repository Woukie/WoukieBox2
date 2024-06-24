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
import 'chat_message.dart' as _i3;
import 'client/add_chat_members.dart' as _i4;
import 'client/chat_message.dart' as _i5;
import 'client/create_chat.dart' as _i6;
import 'client/delete_chat.dart' as _i7;
import 'client/friend_update.dart' as _i8;
import 'client/kick_chat_member.dart' as _i9;
import 'client/leave_chat.dart' as _i10;
import 'client/promote_chat_member.dart' as _i11;
import 'client/read_chat.dart' as _i12;
import 'client/update_profile.dart' as _i13;
import 'client/user.dart' as _i14;
import 'last_read.dart' as _i15;
import 'server/add_chat_members.dart' as _i16;
import 'server/chat_message.dart' as _i17;
import 'server/chats.dart' as _i18;
import 'server/create_chat.dart' as _i19;
import 'server/friend_list.dart' as _i20;
import 'server/join_chat.dart' as _i21;
import 'server/kick_chat_member.dart' as _i22;
import 'server/last_read.dart' as _i23;
import 'server/leave_chat.dart' as _i24;
import 'server/promote_chat_member.dart' as _i25;
import 'server/read_chat.dart' as _i26;
import 'server/room_members.dart' as _i27;
import 'server/self_identifier.dart' as _i28;
import 'server/update_profile.dart' as _i29;
import 'server/user.dart' as _i30;
import 'shared/rename_chat.dart' as _i31;
import 'user_persistent.dart' as _i32;
import 'protocol.dart' as _i33;
import 'package:woukiebox2_client/src/protocol/chat_message.dart' as _i34;
import 'package:serverpod_auth_client/module.dart' as _i35;
export 'chat.dart';
export 'chat_message.dart';
export 'client/add_chat_members.dart';
export 'client/chat_message.dart';
export 'client/create_chat.dart';
export 'client/delete_chat.dart';
export 'client/friend_update.dart';
export 'client/kick_chat_member.dart';
export 'client/leave_chat.dart';
export 'client/promote_chat_member.dart';
export 'client/read_chat.dart';
export 'client/update_profile.dart';
export 'client/user.dart';
export 'last_read.dart';
export 'server/add_chat_members.dart';
export 'server/chat_message.dart';
export 'server/chats.dart';
export 'server/create_chat.dart';
export 'server/friend_list.dart';
export 'server/join_chat.dart';
export 'server/kick_chat_member.dart';
export 'server/last_read.dart';
export 'server/leave_chat.dart';
export 'server/promote_chat_member.dart';
export 'server/read_chat.dart';
export 'server/room_members.dart';
export 'server/self_identifier.dart';
export 'server/update_profile.dart';
export 'server/user.dart';
export 'shared/rename_chat.dart';
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
    if (t == _i3.ChatMessage) {
      return _i3.ChatMessage.fromJson(data, this) as T;
    }
    if (t == _i4.AddChatMembersClient) {
      return _i4.AddChatMembersClient.fromJson(data, this) as T;
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
    if (t == _i9.KickChatMemberClient) {
      return _i9.KickChatMemberClient.fromJson(data, this) as T;
    }
    if (t == _i10.LeaveChatClient) {
      return _i10.LeaveChatClient.fromJson(data, this) as T;
    }
    if (t == _i11.PromoteChatMemberClient) {
      return _i11.PromoteChatMemberClient.fromJson(data, this) as T;
    }
    if (t == _i12.ReadChatClient) {
      return _i12.ReadChatClient.fromJson(data, this) as T;
    }
    if (t == _i13.UpdateProfileClient) {
      return _i13.UpdateProfileClient.fromJson(data, this) as T;
    }
    if (t == _i14.UserClient) {
      return _i14.UserClient.fromJson(data, this) as T;
    }
    if (t == _i15.LastRead) {
      return _i15.LastRead.fromJson(data, this) as T;
    }
    if (t == _i16.AddChatMembersServer) {
      return _i16.AddChatMembersServer.fromJson(data, this) as T;
    }
    if (t == _i17.ChatMessageServer) {
      return _i17.ChatMessageServer.fromJson(data, this) as T;
    }
    if (t == _i18.ChatsServer) {
      return _i18.ChatsServer.fromJson(data, this) as T;
    }
    if (t == _i19.CreateChatServer) {
      return _i19.CreateChatServer.fromJson(data, this) as T;
    }
    if (t == _i20.FriendListServer) {
      return _i20.FriendListServer.fromJson(data, this) as T;
    }
    if (t == _i21.JoinChatServer) {
      return _i21.JoinChatServer.fromJson(data, this) as T;
    }
    if (t == _i22.KickChatMemberServer) {
      return _i22.KickChatMemberServer.fromJson(data, this) as T;
    }
    if (t == _i23.LastReadServer) {
      return _i23.LastReadServer.fromJson(data, this) as T;
    }
    if (t == _i24.LeaveChatServer) {
      return _i24.LeaveChatServer.fromJson(data, this) as T;
    }
    if (t == _i25.PromoteChatMemberServer) {
      return _i25.PromoteChatMemberServer.fromJson(data, this) as T;
    }
    if (t == _i26.ReadChatServer) {
      return _i26.ReadChatServer.fromJson(data, this) as T;
    }
    if (t == _i27.RoomMembersServer) {
      return _i27.RoomMembersServer.fromJson(data, this) as T;
    }
    if (t == _i28.SelfIdentifierServer) {
      return _i28.SelfIdentifierServer.fromJson(data, this) as T;
    }
    if (t == _i29.UpdateProfileServer) {
      return _i29.UpdateProfileServer.fromJson(data, this) as T;
    }
    if (t == _i30.UserServer) {
      return _i30.UserServer.fromJson(data, this) as T;
    }
    if (t == _i31.RenameChat) {
      return _i31.RenameChat.fromJson(data, this) as T;
    }
    if (t == _i32.UserPersistent) {
      return _i32.UserPersistent.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i2.Chat?>()) {
      return (data != null ? _i2.Chat.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i3.ChatMessage?>()) {
      return (data != null ? _i3.ChatMessage.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i4.AddChatMembersClient?>()) {
      return (data != null
          ? _i4.AddChatMembersClient.fromJson(data, this)
          : null) as T;
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
    if (t == _i1.getType<_i9.KickChatMemberClient?>()) {
      return (data != null
          ? _i9.KickChatMemberClient.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i10.LeaveChatClient?>()) {
      return (data != null ? _i10.LeaveChatClient.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i11.PromoteChatMemberClient?>()) {
      return (data != null
          ? _i11.PromoteChatMemberClient.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i12.ReadChatClient?>()) {
      return (data != null ? _i12.ReadChatClient.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i13.UpdateProfileClient?>()) {
      return (data != null
          ? _i13.UpdateProfileClient.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i14.UserClient?>()) {
      return (data != null ? _i14.UserClient.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i15.LastRead?>()) {
      return (data != null ? _i15.LastRead.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i16.AddChatMembersServer?>()) {
      return (data != null
          ? _i16.AddChatMembersServer.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i17.ChatMessageServer?>()) {
      return (data != null ? _i17.ChatMessageServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i18.ChatsServer?>()) {
      return (data != null ? _i18.ChatsServer.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i19.CreateChatServer?>()) {
      return (data != null ? _i19.CreateChatServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i20.FriendListServer?>()) {
      return (data != null ? _i20.FriendListServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i21.JoinChatServer?>()) {
      return (data != null ? _i21.JoinChatServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i22.KickChatMemberServer?>()) {
      return (data != null
          ? _i22.KickChatMemberServer.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i23.LastReadServer?>()) {
      return (data != null ? _i23.LastReadServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i24.LeaveChatServer?>()) {
      return (data != null ? _i24.LeaveChatServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i25.PromoteChatMemberServer?>()) {
      return (data != null
          ? _i25.PromoteChatMemberServer.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i26.ReadChatServer?>()) {
      return (data != null ? _i26.ReadChatServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i27.RoomMembersServer?>()) {
      return (data != null ? _i27.RoomMembersServer.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i28.SelfIdentifierServer?>()) {
      return (data != null
          ? _i28.SelfIdentifierServer.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i29.UpdateProfileServer?>()) {
      return (data != null
          ? _i29.UpdateProfileServer.fromJson(data, this)
          : null) as T;
    }
    if (t == _i1.getType<_i30.UserServer?>()) {
      return (data != null ? _i30.UserServer.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i31.RenameChat?>()) {
      return (data != null ? _i31.RenameChat.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i32.UserPersistent?>()) {
      return (data != null ? _i32.UserPersistent.fromJson(data, this) : null)
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as dynamic;
    }
    if (t == List<_i33.Chat>) {
      return (data as List).map((e) => deserialize<_i33.Chat>(e)).toList()
          as dynamic;
    }
    if (t == Map<int, DateTime>) {
      return Map.fromEntries((data as List).map((e) => MapEntry(
          deserialize<int>(e['k']), deserialize<DateTime>(e['v'])))) as dynamic;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toList()
          : null) as dynamic;
    }
    if (t == List<_i33.UserServer>) {
      return (data as List).map((e) => deserialize<_i33.UserServer>(e)).toList()
          as dynamic;
    }
    if (t == _i1.getType<List<_i34.ChatMessage>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i34.ChatMessage>(e)).toList()
          : null) as dynamic;
    }
    try {
      return _i35.Protocol().deserialize<T>(data, t);
    } catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    String? className;
    className = _i35.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is _i2.Chat) {
      return 'Chat';
    }
    if (data is _i3.ChatMessage) {
      return 'ChatMessage';
    }
    if (data is _i4.AddChatMembersClient) {
      return 'AddChatMembersClient';
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
    if (data is _i9.KickChatMemberClient) {
      return 'KickChatMemberClient';
    }
    if (data is _i10.LeaveChatClient) {
      return 'LeaveChatClient';
    }
    if (data is _i11.PromoteChatMemberClient) {
      return 'PromoteChatMemberClient';
    }
    if (data is _i12.ReadChatClient) {
      return 'ReadChatClient';
    }
    if (data is _i13.UpdateProfileClient) {
      return 'UpdateProfileClient';
    }
    if (data is _i14.UserClient) {
      return 'UserClient';
    }
    if (data is _i15.LastRead) {
      return 'LastRead';
    }
    if (data is _i16.AddChatMembersServer) {
      return 'AddChatMembersServer';
    }
    if (data is _i17.ChatMessageServer) {
      return 'ChatMessageServer';
    }
    if (data is _i18.ChatsServer) {
      return 'ChatsServer';
    }
    if (data is _i19.CreateChatServer) {
      return 'CreateChatServer';
    }
    if (data is _i20.FriendListServer) {
      return 'FriendListServer';
    }
    if (data is _i21.JoinChatServer) {
      return 'JoinChatServer';
    }
    if (data is _i22.KickChatMemberServer) {
      return 'KickChatMemberServer';
    }
    if (data is _i23.LastReadServer) {
      return 'LastReadServer';
    }
    if (data is _i24.LeaveChatServer) {
      return 'LeaveChatServer';
    }
    if (data is _i25.PromoteChatMemberServer) {
      return 'PromoteChatMemberServer';
    }
    if (data is _i26.ReadChatServer) {
      return 'ReadChatServer';
    }
    if (data is _i27.RoomMembersServer) {
      return 'RoomMembersServer';
    }
    if (data is _i28.SelfIdentifierServer) {
      return 'SelfIdentifierServer';
    }
    if (data is _i29.UpdateProfileServer) {
      return 'UpdateProfileServer';
    }
    if (data is _i30.UserServer) {
      return 'UserServer';
    }
    if (data is _i31.RenameChat) {
      return 'RenameChat';
    }
    if (data is _i32.UserPersistent) {
      return 'UserPersistent';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'].startsWith('serverpod_auth.')) {
      data['className'] = data['className'].substring(15);
      return _i35.Protocol().deserializeByClassName(data);
    }
    if (data['className'] == 'Chat') {
      return deserialize<_i2.Chat>(data['data']);
    }
    if (data['className'] == 'ChatMessage') {
      return deserialize<_i3.ChatMessage>(data['data']);
    }
    if (data['className'] == 'AddChatMembersClient') {
      return deserialize<_i4.AddChatMembersClient>(data['data']);
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
    if (data['className'] == 'KickChatMemberClient') {
      return deserialize<_i9.KickChatMemberClient>(data['data']);
    }
    if (data['className'] == 'LeaveChatClient') {
      return deserialize<_i10.LeaveChatClient>(data['data']);
    }
    if (data['className'] == 'PromoteChatMemberClient') {
      return deserialize<_i11.PromoteChatMemberClient>(data['data']);
    }
    if (data['className'] == 'ReadChatClient') {
      return deserialize<_i12.ReadChatClient>(data['data']);
    }
    if (data['className'] == 'UpdateProfileClient') {
      return deserialize<_i13.UpdateProfileClient>(data['data']);
    }
    if (data['className'] == 'UserClient') {
      return deserialize<_i14.UserClient>(data['data']);
    }
    if (data['className'] == 'LastRead') {
      return deserialize<_i15.LastRead>(data['data']);
    }
    if (data['className'] == 'AddChatMembersServer') {
      return deserialize<_i16.AddChatMembersServer>(data['data']);
    }
    if (data['className'] == 'ChatMessageServer') {
      return deserialize<_i17.ChatMessageServer>(data['data']);
    }
    if (data['className'] == 'ChatsServer') {
      return deserialize<_i18.ChatsServer>(data['data']);
    }
    if (data['className'] == 'CreateChatServer') {
      return deserialize<_i19.CreateChatServer>(data['data']);
    }
    if (data['className'] == 'FriendListServer') {
      return deserialize<_i20.FriendListServer>(data['data']);
    }
    if (data['className'] == 'JoinChatServer') {
      return deserialize<_i21.JoinChatServer>(data['data']);
    }
    if (data['className'] == 'KickChatMemberServer') {
      return deserialize<_i22.KickChatMemberServer>(data['data']);
    }
    if (data['className'] == 'LastReadServer') {
      return deserialize<_i23.LastReadServer>(data['data']);
    }
    if (data['className'] == 'LeaveChatServer') {
      return deserialize<_i24.LeaveChatServer>(data['data']);
    }
    if (data['className'] == 'PromoteChatMemberServer') {
      return deserialize<_i25.PromoteChatMemberServer>(data['data']);
    }
    if (data['className'] == 'ReadChatServer') {
      return deserialize<_i26.ReadChatServer>(data['data']);
    }
    if (data['className'] == 'RoomMembersServer') {
      return deserialize<_i27.RoomMembersServer>(data['data']);
    }
    if (data['className'] == 'SelfIdentifierServer') {
      return deserialize<_i28.SelfIdentifierServer>(data['data']);
    }
    if (data['className'] == 'UpdateProfileServer') {
      return deserialize<_i29.UpdateProfileServer>(data['data']);
    }
    if (data['className'] == 'UserServer') {
      return deserialize<_i30.UserServer>(data['data']);
    }
    if (data['className'] == 'RenameChat') {
      return deserialize<_i31.RenameChat>(data['data']);
    }
    if (data['className'] == 'UserPersistent') {
      return deserialize<_i32.UserPersistent>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
