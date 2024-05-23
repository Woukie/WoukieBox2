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
import 'self_identifier.dart' as _i7;
import 'system_message.dart' as _i8;
import 'update_profile.dart' as _i9;
import 'user.dart' as _i10;
import 'protocol.dart' as _i11;
import 'package:serverpod_auth_client/module.dart' as _i12;
export 'example.dart';
export 'chat_message.dart';
export 'join_message.dart';
export 'leave_message.dart';
export 'room_members.dart';
export 'self_identifier.dart';
export 'system_message.dart';
export 'update_profile.dart';
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
    if (t == _i7.SelfIdentifier) {
      return _i7.SelfIdentifier.fromJson(data, this) as T;
    }
    if (t == _i8.SystemMessage) {
      return _i8.SystemMessage.fromJson(data, this) as T;
    }
    if (t == _i9.UpdateProfile) {
      return _i9.UpdateProfile.fromJson(data, this) as T;
    }
    if (t == _i10.User) {
      return _i10.User.fromJson(data, this) as T;
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
    if (t == _i1.getType<_i7.SelfIdentifier?>()) {
      return (data != null ? _i7.SelfIdentifier.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i8.SystemMessage?>()) {
      return (data != null ? _i8.SystemMessage.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i9.UpdateProfile?>()) {
      return (data != null ? _i9.UpdateProfile.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i10.User?>()) {
      return (data != null ? _i10.User.fromJson(data, this) : null) as T;
    }
    if (t == List<_i11.User>) {
      return (data as List).map((e) => deserialize<_i11.User>(e)).toList()
          as dynamic;
    }
    try {
      return _i12.Protocol().deserialize<T>(data, t);
    } catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    String? className;
    className = _i12.Protocol().getClassNameForObject(data);
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
    if (data is _i7.SelfIdentifier) {
      return 'SelfIdentifier';
    }
    if (data is _i8.SystemMessage) {
      return 'SystemMessage';
    }
    if (data is _i9.UpdateProfile) {
      return 'UpdateProfile';
    }
    if (data is _i10.User) {
      return 'User';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'].startsWith('serverpod_auth.')) {
      data['className'] = data['className'].substring(15);
      return _i12.Protocol().deserializeByClassName(data);
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
    if (data['className'] == 'SelfIdentifier') {
      return deserialize<_i7.SelfIdentifier>(data['data']);
    }
    if (data['className'] == 'SystemMessage') {
      return deserialize<_i8.SystemMessage>(data['data']);
    }
    if (data['className'] == 'UpdateProfile') {
      return deserialize<_i9.UpdateProfile>(data['data']);
    }
    if (data['className'] == 'User') {
      return deserialize<_i10.User>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
