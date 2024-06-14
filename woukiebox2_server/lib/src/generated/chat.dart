/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod_serialization/serverpod_serialization.dart';

abstract class Chat extends _i1.TableRow {
  Chat._({
    int? id,
    required this.users,
    required this.owners,
    required this.creator,
    required this.name,
  }) : super(id);

  factory Chat({
    int? id,
    required List<int> users,
    required List<int> owners,
    required int creator,
    required String name,
  }) = _ChatImpl;

  factory Chat.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Chat(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      users: serializationManager
          .deserialize<List<int>>(jsonSerialization['users']),
      owners: serializationManager
          .deserialize<List<int>>(jsonSerialization['owners']),
      creator:
          serializationManager.deserialize<int>(jsonSerialization['creator']),
      name: serializationManager.deserialize<String>(jsonSerialization['name']),
    );
  }

  static final t = ChatTable();

  static const db = ChatRepository._();

  List<int> users;

  List<int> owners;

  int creator;

  String name;

  @override
  _i1.Table get table => t;

  Chat copyWith({
    int? id,
    List<int>? users,
    List<int>? owners,
    int? creator,
    String? name,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'users': users.toJson(),
      'owners': owners.toJson(),
      'creator': creator,
      'name': name,
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'users': users,
      'owners': owners,
      'creator': creator,
      'name': name,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'users': users.toJson(),
      'owners': owners.toJson(),
      'creator': creator,
      'name': name,
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
      case 'users':
        users = value;
        return;
      case 'owners':
        owners = value;
        return;
      case 'creator':
        creator = value;
        return;
      case 'name':
        name = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<Chat>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChatTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Chat>(
      where: where != null ? where(Chat.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findRow instead.')
  static Future<Chat?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChatTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<Chat>(
      where: where != null ? where(Chat.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<Chat?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<Chat>(id);
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ChatTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Chat>(
      where: where(Chat.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    Chat row, {
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
    Chat row, {
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
    Chat row, {
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
    _i1.WhereExpressionBuilder<ChatTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Chat>(
      where: where != null ? where(Chat.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static ChatInclude include() {
    return ChatInclude._();
  }

  static ChatIncludeList includeList({
    _i1.WhereExpressionBuilder<ChatTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChatTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChatTable>? orderByList,
    ChatInclude? include,
  }) {
    return ChatIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Chat.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Chat.t),
      include: include,
    );
  }
}

class _Undefined {}

class _ChatImpl extends Chat {
  _ChatImpl({
    int? id,
    required List<int> users,
    required List<int> owners,
    required int creator,
    required String name,
  }) : super._(
          id: id,
          users: users,
          owners: owners,
          creator: creator,
          name: name,
        );

  @override
  Chat copyWith({
    Object? id = _Undefined,
    List<int>? users,
    List<int>? owners,
    int? creator,
    String? name,
  }) {
    return Chat(
      id: id is int? ? id : this.id,
      users: users ?? this.users.clone(),
      owners: owners ?? this.owners.clone(),
      creator: creator ?? this.creator,
      name: name ?? this.name,
    );
  }
}

class ChatTable extends _i1.Table {
  ChatTable({super.tableRelation}) : super(tableName: 'chat') {
    users = _i1.ColumnSerializable(
      'users',
      this,
    );
    owners = _i1.ColumnSerializable(
      'owners',
      this,
    );
    creator = _i1.ColumnInt(
      'creator',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
  }

  late final _i1.ColumnSerializable users;

  late final _i1.ColumnSerializable owners;

  late final _i1.ColumnInt creator;

  late final _i1.ColumnString name;

  @override
  List<_i1.Column> get columns => [
        id,
        users,
        owners,
        creator,
        name,
      ];
}

@Deprecated('Use ChatTable.t instead.')
ChatTable tChat = ChatTable();

class ChatInclude extends _i1.IncludeObject {
  ChatInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Chat.t;
}

class ChatIncludeList extends _i1.IncludeList {
  ChatIncludeList._({
    _i1.WhereExpressionBuilder<ChatTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Chat.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Chat.t;
}

class ChatRepository {
  const ChatRepository._();

  Future<List<Chat>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChatTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChatTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChatTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.find<Chat>(
      where: where?.call(Chat.t),
      orderBy: orderBy?.call(Chat.t),
      orderByList: orderByList?.call(Chat.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Chat?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChatTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChatTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChatTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.findFirstRow<Chat>(
      where: where?.call(Chat.t),
      orderBy: orderBy?.call(Chat.t),
      orderByList: orderByList?.call(Chat.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Chat?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.findById<Chat>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Chat>> insert(
    _i1.Session session,
    List<Chat> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<Chat>(
      rows,
      transaction: transaction,
    );
  }

  Future<Chat> insertRow(
    _i1.Session session,
    Chat row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<Chat>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Chat>> update(
    _i1.Session session,
    List<Chat> rows, {
    _i1.ColumnSelections<ChatTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.update<Chat>(
      rows,
      columns: columns?.call(Chat.t),
      transaction: transaction,
    );
  }

  Future<Chat> updateRow(
    _i1.Session session,
    Chat row, {
    _i1.ColumnSelections<ChatTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.updateRow<Chat>(
      row,
      columns: columns?.call(Chat.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<Chat> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<Chat>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    Chat row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<Chat>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ChatTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<Chat>(
      where: where(Chat.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChatTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.count<Chat>(
      where: where?.call(Chat.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
