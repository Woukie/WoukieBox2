/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod_auth_server/module.dart' as _i2;
import 'package:serverpod_serialization/serverpod_serialization.dart';

abstract class UserPersistent extends _i1.TableRow {
  UserPersistent._({
    int? id,
    required this.userInfoId,
    this.userInfo,
    required this.color,
    required this.bio,
    required this.image,
    required this.chats,
    required this.friends,
    required this.outgoingFriendRequests,
    required this.incomingFriendRequests,
  }) : super(id);

  factory UserPersistent({
    int? id,
    required int userInfoId,
    _i2.UserInfo? userInfo,
    required String color,
    required String bio,
    required String image,
    required List<int> chats,
    required List<int> friends,
    required List<int> outgoingFriendRequests,
    required List<int> incomingFriendRequests,
  }) = _UserPersistentImpl;

  factory UserPersistent.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return UserPersistent(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      userInfoId: serializationManager
          .deserialize<int>(jsonSerialization['userInfoId']),
      userInfo: serializationManager
          .deserialize<_i2.UserInfo?>(jsonSerialization['userInfo']),
      color:
          serializationManager.deserialize<String>(jsonSerialization['color']),
      bio: serializationManager.deserialize<String>(jsonSerialization['bio']),
      image:
          serializationManager.deserialize<String>(jsonSerialization['image']),
      chats: serializationManager
          .deserialize<List<int>>(jsonSerialization['chats']),
      friends: serializationManager
          .deserialize<List<int>>(jsonSerialization['friends']),
      outgoingFriendRequests: serializationManager
          .deserialize<List<int>>(jsonSerialization['outgoingFriendRequests']),
      incomingFriendRequests: serializationManager
          .deserialize<List<int>>(jsonSerialization['incomingFriendRequests']),
    );
  }

  static final t = UserPersistentTable();

  static const db = UserPersistentRepository._();

  int userInfoId;

  _i2.UserInfo? userInfo;

  String color;

  String bio;

  String image;

  List<int> chats;

  List<int> friends;

  List<int> outgoingFriendRequests;

  List<int> incomingFriendRequests;

  @override
  _i1.Table get table => t;

  UserPersistent copyWith({
    int? id,
    int? userInfoId,
    _i2.UserInfo? userInfo,
    String? color,
    String? bio,
    String? image,
    List<int>? chats,
    List<int>? friends,
    List<int>? outgoingFriendRequests,
    List<int>? incomingFriendRequests,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userInfoId': userInfoId,
      if (userInfo != null) 'userInfo': userInfo?.toJson(),
      'color': color,
      'bio': bio,
      'image': image,
      'chats': chats.toJson(),
      'friends': friends.toJson(),
      'outgoingFriendRequests': outgoingFriendRequests.toJson(),
      'incomingFriendRequests': incomingFriendRequests.toJson(),
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'userInfoId': userInfoId,
      'color': color,
      'bio': bio,
      'image': image,
      'chats': chats,
      'friends': friends,
      'outgoingFriendRequests': outgoingFriendRequests,
      'incomingFriendRequests': incomingFriendRequests,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'userInfoId': userInfoId,
      if (userInfo != null) 'userInfo': userInfo?.allToJson(),
      'color': color,
      'bio': bio,
      'image': image,
      'chats': chats.toJson(),
      'friends': friends.toJson(),
      'outgoingFriendRequests': outgoingFriendRequests.toJson(),
      'incomingFriendRequests': incomingFriendRequests.toJson(),
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  void setColumn(
    String columnName,
    value,
  ) {
    switch (columnName) {
      case 'id':
        id = value;
        return;
      case 'userInfoId':
        userInfoId = value;
        return;
      case 'color':
        color = value;
        return;
      case 'bio':
        bio = value;
        return;
      case 'image':
        image = value;
        return;
      case 'chats':
        chats = value;
        return;
      case 'friends':
        friends = value;
        return;
      case 'outgoingFriendRequests':
        outgoingFriendRequests = value;
        return;
      case 'incomingFriendRequests':
        incomingFriendRequests = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<UserPersistent>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserPersistentTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    UserPersistentInclude? include,
  }) async {
    return session.db.find<UserPersistent>(
      where: where != null ? where(UserPersistent.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findRow instead.')
  static Future<UserPersistent?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserPersistentTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    UserPersistentInclude? include,
  }) async {
    return session.db.findSingleRow<UserPersistent>(
      where: where != null ? where(UserPersistent.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<UserPersistent?> findById(
    _i1.Session session,
    int id, {
    UserPersistentInclude? include,
  }) async {
    return session.db.findById<UserPersistent>(
      id,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserPersistentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserPersistent>(
      where: where(UserPersistent.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    UserPersistent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.update instead.')
  static Future<bool> update(
    _i1.Session session,
    UserPersistent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  @Deprecated(
      'Will be removed in 2.0.0. Use: db.insert instead. Important note: In db.insert, the object you pass in is no longer modified, instead a new copy with the added row is returned which contains the inserted id.')
  static Future<void> insert(
    _i1.Session session,
    UserPersistent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.count instead.')
  static Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserPersistentTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserPersistent>(
      where: where != null ? where(UserPersistent.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static UserPersistentInclude include({_i2.UserInfoInclude? userInfo}) {
    return UserPersistentInclude._(userInfo: userInfo);
  }

  static UserPersistentIncludeList includeList({
    _i1.WhereExpressionBuilder<UserPersistentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserPersistentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserPersistentTable>? orderByList,
    UserPersistentInclude? include,
  }) {
    return UserPersistentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserPersistent.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserPersistent.t),
      include: include,
    );
  }
}

class _Undefined {}

class _UserPersistentImpl extends UserPersistent {
  _UserPersistentImpl({
    int? id,
    required int userInfoId,
    _i2.UserInfo? userInfo,
    required String color,
    required String bio,
    required String image,
    required List<int> chats,
    required List<int> friends,
    required List<int> outgoingFriendRequests,
    required List<int> incomingFriendRequests,
  }) : super._(
          id: id,
          userInfoId: userInfoId,
          userInfo: userInfo,
          color: color,
          bio: bio,
          image: image,
          chats: chats,
          friends: friends,
          outgoingFriendRequests: outgoingFriendRequests,
          incomingFriendRequests: incomingFriendRequests,
        );

  @override
  UserPersistent copyWith({
    Object? id = _Undefined,
    int? userInfoId,
    Object? userInfo = _Undefined,
    String? color,
    String? bio,
    String? image,
    List<int>? chats,
    List<int>? friends,
    List<int>? outgoingFriendRequests,
    List<int>? incomingFriendRequests,
  }) {
    return UserPersistent(
      id: id is int? ? id : this.id,
      userInfoId: userInfoId ?? this.userInfoId,
      userInfo:
          userInfo is _i2.UserInfo? ? userInfo : this.userInfo?.copyWith(),
      color: color ?? this.color,
      bio: bio ?? this.bio,
      image: image ?? this.image,
      chats: chats ?? this.chats.clone(),
      friends: friends ?? this.friends.clone(),
      outgoingFriendRequests:
          outgoingFriendRequests ?? this.outgoingFriendRequests.clone(),
      incomingFriendRequests:
          incomingFriendRequests ?? this.incomingFriendRequests.clone(),
    );
  }
}

class UserPersistentTable extends _i1.Table {
  UserPersistentTable({super.tableRelation})
      : super(tableName: 'userpersistent') {
    userInfoId = _i1.ColumnInt(
      'userInfoId',
      this,
    );
    color = _i1.ColumnString(
      'color',
      this,
    );
    bio = _i1.ColumnString(
      'bio',
      this,
    );
    image = _i1.ColumnString(
      'image',
      this,
    );
    chats = _i1.ColumnSerializable(
      'chats',
      this,
    );
    friends = _i1.ColumnSerializable(
      'friends',
      this,
    );
    outgoingFriendRequests = _i1.ColumnSerializable(
      'outgoingFriendRequests',
      this,
    );
    incomingFriendRequests = _i1.ColumnSerializable(
      'incomingFriendRequests',
      this,
    );
  }

  late final _i1.ColumnInt userInfoId;

  _i2.UserInfoTable? _userInfo;

  late final _i1.ColumnString color;

  late final _i1.ColumnString bio;

  late final _i1.ColumnString image;

  late final _i1.ColumnSerializable chats;

  late final _i1.ColumnSerializable friends;

  late final _i1.ColumnSerializable outgoingFriendRequests;

  late final _i1.ColumnSerializable incomingFriendRequests;

  _i2.UserInfoTable get userInfo {
    if (_userInfo != null) return _userInfo!;
    _userInfo = _i1.createRelationTable(
      relationFieldName: 'userInfo',
      field: UserPersistent.t.userInfoId,
      foreignField: _i2.UserInfo.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserInfoTable(tableRelation: foreignTableRelation),
    );
    return _userInfo!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        userInfoId,
        color,
        bio,
        image,
        chats,
        friends,
        outgoingFriendRequests,
        incomingFriendRequests,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'userInfo') {
      return userInfo;
    }
    return null;
  }
}

@Deprecated('Use UserPersistentTable.t instead.')
UserPersistentTable tUserPersistent = UserPersistentTable();

class UserPersistentInclude extends _i1.IncludeObject {
  UserPersistentInclude._({_i2.UserInfoInclude? userInfo}) {
    _userInfo = userInfo;
  }

  _i2.UserInfoInclude? _userInfo;

  @override
  Map<String, _i1.Include?> get includes => {'userInfo': _userInfo};

  @override
  _i1.Table get table => UserPersistent.t;
}

class UserPersistentIncludeList extends _i1.IncludeList {
  UserPersistentIncludeList._({
    _i1.WhereExpressionBuilder<UserPersistentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserPersistent.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => UserPersistent.t;
}

class UserPersistentRepository {
  const UserPersistentRepository._();

  final attachRow = const UserPersistentAttachRowRepository._();

  Future<List<UserPersistent>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserPersistentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserPersistentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserPersistentTable>? orderByList,
    _i1.Transaction? transaction,
    UserPersistentInclude? include,
  }) async {
    return session.dbNext.find<UserPersistent>(
      where: where?.call(UserPersistent.t),
      orderBy: orderBy?.call(UserPersistent.t),
      orderByList: orderByList?.call(UserPersistent.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<UserPersistent?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserPersistentTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserPersistentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserPersistentTable>? orderByList,
    _i1.Transaction? transaction,
    UserPersistentInclude? include,
  }) async {
    return session.dbNext.findFirstRow<UserPersistent>(
      where: where?.call(UserPersistent.t),
      orderBy: orderBy?.call(UserPersistent.t),
      orderByList: orderByList?.call(UserPersistent.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<UserPersistent?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    UserPersistentInclude? include,
  }) async {
    return session.dbNext.findById<UserPersistent>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<UserPersistent>> insert(
    _i1.Session session,
    List<UserPersistent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<UserPersistent>(
      rows,
      transaction: transaction,
    );
  }

  Future<UserPersistent> insertRow(
    _i1.Session session,
    UserPersistent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<UserPersistent>(
      row,
      transaction: transaction,
    );
  }

  Future<List<UserPersistent>> update(
    _i1.Session session,
    List<UserPersistent> rows, {
    _i1.ColumnSelections<UserPersistentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.update<UserPersistent>(
      rows,
      columns: columns?.call(UserPersistent.t),
      transaction: transaction,
    );
  }

  Future<UserPersistent> updateRow(
    _i1.Session session,
    UserPersistent row, {
    _i1.ColumnSelections<UserPersistentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.updateRow<UserPersistent>(
      row,
      columns: columns?.call(UserPersistent.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<UserPersistent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<UserPersistent>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    UserPersistent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<UserPersistent>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserPersistentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<UserPersistent>(
      where: where(UserPersistent.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserPersistentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.count<UserPersistent>(
      where: where?.call(UserPersistent.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class UserPersistentAttachRowRepository {
  const UserPersistentAttachRowRepository._();

  Future<void> userInfo(
    _i1.Session session,
    UserPersistent userPersistent,
    _i2.UserInfo userInfo,
  ) async {
    if (userPersistent.id == null) {
      throw ArgumentError.notNull('userPersistent.id');
    }
    if (userInfo.id == null) {
      throw ArgumentError.notNull('userInfo.id');
    }

    var $userPersistent = userPersistent.copyWith(userInfoId: userInfo.id);
    await session.dbNext.updateRow<UserPersistent>(
      $userPersistent,
      columns: [UserPersistent.t.userInfoId],
    );
  }
}
