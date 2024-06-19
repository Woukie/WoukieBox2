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
import 'protocol.dart' as _i3;
import 'package:serverpod_serialization/serverpod_serialization.dart';

abstract class LastRead extends _i1.TableRow {
  LastRead._({
    int? id,
    required this.userInfoId,
    this.userInfo,
    required this.chatId,
    this.chat,
    required this.readAt,
  }) : super(id);

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

  static final t = LastReadTable();

  static const db = LastReadRepository._();

  int userInfoId;

  _i2.UserInfo? userInfo;

  int chatId;

  _i3.Chat? chat;

  DateTime readAt;

  @override
  _i1.Table get table => t;

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

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'userInfoId': userInfoId,
      'chatId': chatId,
      'readAt': readAt,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'userInfoId': userInfoId,
      if (userInfo != null) 'userInfo': userInfo?.allToJson(),
      'chatId': chatId,
      if (chat != null) 'chat': chat?.allToJson(),
      'readAt': readAt.toJson(),
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
      case 'chatId':
        chatId = value;
        return;
      case 'readAt':
        readAt = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<LastRead>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LastReadTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    LastReadInclude? include,
  }) async {
    return session.db.find<LastRead>(
      where: where != null ? where(LastRead.t) : null,
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
  static Future<LastRead?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LastReadTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    LastReadInclude? include,
  }) async {
    return session.db.findSingleRow<LastRead>(
      where: where != null ? where(LastRead.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<LastRead?> findById(
    _i1.Session session,
    int id, {
    LastReadInclude? include,
  }) async {
    return session.db.findById<LastRead>(
      id,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LastReadTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LastRead>(
      where: where(LastRead.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    LastRead row, {
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
    LastRead row, {
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
    LastRead row, {
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
    _i1.WhereExpressionBuilder<LastReadTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LastRead>(
      where: where != null ? where(LastRead.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static LastReadInclude include({
    _i2.UserInfoInclude? userInfo,
    _i3.ChatInclude? chat,
  }) {
    return LastReadInclude._(
      userInfo: userInfo,
      chat: chat,
    );
  }

  static LastReadIncludeList includeList({
    _i1.WhereExpressionBuilder<LastReadTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LastReadTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LastReadTable>? orderByList,
    LastReadInclude? include,
  }) {
    return LastReadIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LastRead.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LastRead.t),
      include: include,
    );
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

class LastReadTable extends _i1.Table {
  LastReadTable({super.tableRelation}) : super(tableName: 'lastread') {
    userInfoId = _i1.ColumnInt(
      'userInfoId',
      this,
    );
    chatId = _i1.ColumnInt(
      'chatId',
      this,
    );
    readAt = _i1.ColumnDateTime(
      'readAt',
      this,
    );
  }

  late final _i1.ColumnInt userInfoId;

  _i2.UserInfoTable? _userInfo;

  late final _i1.ColumnInt chatId;

  _i3.ChatTable? _chat;

  late final _i1.ColumnDateTime readAt;

  _i2.UserInfoTable get userInfo {
    if (_userInfo != null) return _userInfo!;
    _userInfo = _i1.createRelationTable(
      relationFieldName: 'userInfo',
      field: LastRead.t.userInfoId,
      foreignField: _i2.UserInfo.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserInfoTable(tableRelation: foreignTableRelation),
    );
    return _userInfo!;
  }

  _i3.ChatTable get chat {
    if (_chat != null) return _chat!;
    _chat = _i1.createRelationTable(
      relationFieldName: 'chat',
      field: LastRead.t.chatId,
      foreignField: _i3.Chat.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ChatTable(tableRelation: foreignTableRelation),
    );
    return _chat!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        userInfoId,
        chatId,
        readAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'userInfo') {
      return userInfo;
    }
    if (relationField == 'chat') {
      return chat;
    }
    return null;
  }
}

@Deprecated('Use LastReadTable.t instead.')
LastReadTable tLastRead = LastReadTable();

class LastReadInclude extends _i1.IncludeObject {
  LastReadInclude._({
    _i2.UserInfoInclude? userInfo,
    _i3.ChatInclude? chat,
  }) {
    _userInfo = userInfo;
    _chat = chat;
  }

  _i2.UserInfoInclude? _userInfo;

  _i3.ChatInclude? _chat;

  @override
  Map<String, _i1.Include?> get includes => {
        'userInfo': _userInfo,
        'chat': _chat,
      };

  @override
  _i1.Table get table => LastRead.t;
}

class LastReadIncludeList extends _i1.IncludeList {
  LastReadIncludeList._({
    _i1.WhereExpressionBuilder<LastReadTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LastRead.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => LastRead.t;
}

class LastReadRepository {
  const LastReadRepository._();

  final attachRow = const LastReadAttachRowRepository._();

  Future<List<LastRead>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LastReadTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LastReadTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LastReadTable>? orderByList,
    _i1.Transaction? transaction,
    LastReadInclude? include,
  }) async {
    return session.dbNext.find<LastRead>(
      where: where?.call(LastRead.t),
      orderBy: orderBy?.call(LastRead.t),
      orderByList: orderByList?.call(LastRead.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<LastRead?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LastReadTable>? where,
    int? offset,
    _i1.OrderByBuilder<LastReadTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LastReadTable>? orderByList,
    _i1.Transaction? transaction,
    LastReadInclude? include,
  }) async {
    return session.dbNext.findFirstRow<LastRead>(
      where: where?.call(LastRead.t),
      orderBy: orderBy?.call(LastRead.t),
      orderByList: orderByList?.call(LastRead.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<LastRead?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    LastReadInclude? include,
  }) async {
    return session.dbNext.findById<LastRead>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<LastRead>> insert(
    _i1.Session session,
    List<LastRead> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<LastRead>(
      rows,
      transaction: transaction,
    );
  }

  Future<LastRead> insertRow(
    _i1.Session session,
    LastRead row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<LastRead>(
      row,
      transaction: transaction,
    );
  }

  Future<List<LastRead>> update(
    _i1.Session session,
    List<LastRead> rows, {
    _i1.ColumnSelections<LastReadTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.update<LastRead>(
      rows,
      columns: columns?.call(LastRead.t),
      transaction: transaction,
    );
  }

  Future<LastRead> updateRow(
    _i1.Session session,
    LastRead row, {
    _i1.ColumnSelections<LastReadTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.updateRow<LastRead>(
      row,
      columns: columns?.call(LastRead.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<LastRead> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<LastRead>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    LastRead row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<LastRead>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LastReadTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<LastRead>(
      where: where(LastRead.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LastReadTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.count<LastRead>(
      where: where?.call(LastRead.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class LastReadAttachRowRepository {
  const LastReadAttachRowRepository._();

  Future<void> userInfo(
    _i1.Session session,
    LastRead lastRead,
    _i2.UserInfo userInfo,
  ) async {
    if (lastRead.id == null) {
      throw ArgumentError.notNull('lastRead.id');
    }
    if (userInfo.id == null) {
      throw ArgumentError.notNull('userInfo.id');
    }

    var $lastRead = lastRead.copyWith(userInfoId: userInfo.id);
    await session.dbNext.updateRow<LastRead>(
      $lastRead,
      columns: [LastRead.t.userInfoId],
    );
  }

  Future<void> chat(
    _i1.Session session,
    LastRead lastRead,
    _i3.Chat chat,
  ) async {
    if (lastRead.id == null) {
      throw ArgumentError.notNull('lastRead.id');
    }
    if (chat.id == null) {
      throw ArgumentError.notNull('chat.id');
    }

    var $lastRead = lastRead.copyWith(chatId: chat.id);
    await session.dbNext.updateRow<LastRead>(
      $lastRead,
      columns: [LastRead.t.chatId],
    );
  }
}
