/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'example.dart' as _i2;
import 'chat_message.dart' as _i3;
import 'join_message.dart' as _i4;
import 'leave_message.dart' as _i5;
import 'room_members.dart' as _i6;
import 'system_message.dart' as _i7;
import 'user.dart' as _i8;
import 'protocol.dart' as _i9;
import 'package:serverpod_auth_client/module.dart' as _i10;
export 'example.dart';
export 'chat_message.dart';
export 'join_message.dart';
export 'leave_message.dart';
export 'room_members.dart';
export 'system_message.dart';
export 'user.dart';
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
    if (t == _i2.Example) {
      return _i2.Example.fromJson(data, this) as T;
    }
    if (t == _i3.ChatMessage) {
      return _i3.ChatMessage.fromJson(data, this) as T;
    }
    if (t == _i4.JoinMessage) {
      return _i4.JoinMessage.fromJson(data, this) as T;
    }
    if (t == _i5.LeaveMessage) {
      return _i5.LeaveMessage.fromJson(data, this) as T;
    }
    if (t == _i6.RoomMembers) {
      return _i6.RoomMembers.fromJson(data, this) as T;
    }
    if (t == _i7.SystemMessage) {
      return _i7.SystemMessage.fromJson(data, this) as T;
    }
    if (t == _i8.User) {
      return _i8.User.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i2.Example?>()) {
      return (data != null ? _i2.Example.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i3.ChatMessage?>()) {
      return (data != null ? _i3.ChatMessage.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i4.JoinMessage?>()) {
      return (data != null ? _i4.JoinMessage.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i5.LeaveMessage?>()) {
      return (data != null ? _i5.LeaveMessage.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i6.RoomMembers?>()) {
      return (data != null ? _i6.RoomMembers.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i7.SystemMessage?>()) {
      return (data != null ? _i7.SystemMessage.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i8.User?>()) {
      return (data != null ? _i8.User.fromJson(data, this) : null) as T;
    }
    if (t == List<_i9.User>) {
      return (data as List).map((e) => deserialize<_i9.User>(e)).toList()
          as dynamic;
    }
    try {
      return _i10.Protocol().deserialize<T>(data, t);
    } catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    String? className;
    className = _i10.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is _i2.Example) {
      return 'Example';
    }
    if (data is _i3.ChatMessage) {
      return 'ChatMessage';
    }
    if (data is _i4.JoinMessage) {
      return 'JoinMessage';
    }
    if (data is _i5.LeaveMessage) {
      return 'LeaveMessage';
    }
    if (data is _i6.RoomMembers) {
      return 'RoomMembers';
    }
    if (data is _i7.SystemMessage) {
      return 'SystemMessage';
    }
    if (data is _i8.User) {
      return 'User';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'].startsWith('serverpod_auth.')) {
      data['className'] = data['className'].substring(15);
      return _i10.Protocol().deserializeByClassName(data);
    }
    if (data['className'] == 'Example') {
      return deserialize<_i2.Example>(data['data']);
    }
    if (data['className'] == 'ChatMessage') {
      return deserialize<_i3.ChatMessage>(data['data']);
    }
    if (data['className'] == 'JoinMessage') {
      return deserialize<_i4.JoinMessage>(data['data']);
    }
    if (data['className'] == 'LeaveMessage') {
      return deserialize<_i5.LeaveMessage>(data['data']);
    }
    if (data['className'] == 'RoomMembers') {
      return deserialize<_i6.RoomMembers>(data['data']);
    }
    if (data['className'] == 'SystemMessage') {
      return deserialize<_i7.SystemMessage>(data['data']);
    }
    if (data['className'] == 'User') {
      return deserialize<_i8.User>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
