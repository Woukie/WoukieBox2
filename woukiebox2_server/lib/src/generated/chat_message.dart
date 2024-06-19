/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'protocol.dart' as _i2;
import 'package:serverpod_serialization/serverpod_serialization.dart';

abstract class ChatMessage extends _i1.TableRow {
  ChatMessage._({
    int? id,
    required this.sentAt,
    required this.message,
    required this.senderId,
    this.sender,
    required this.chatId,
    this.chat,
    required this.bucket,
  }) : super(id);

  factory ChatMessage({
    int? id,
    required DateTime sentAt,
    required String message,
    required int senderId,
    _i2.UserPersistent? sender,
    required int chatId,
    _i2.Chat? chat,
    required int bucket,
  }) = _ChatMessageImpl;

  factory ChatMessage.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return ChatMessage(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      sentAt: serializationManager
          .deserialize<DateTime>(jsonSerialization['sentAt']),
      message: serializationManager
          .deserialize<String>(jsonSerialization['message']),
      senderId:
          serializationManager.deserialize<int>(jsonSerialization['senderId']),
      sender: serializationManager
          .deserialize<_i2.UserPersistent?>(jsonSerialization['sender']),
      chatId:
          serializationManager.deserialize<int>(jsonSerialization['chatId']),
      chat: serializationManager
          .deserialize<_i2.Chat?>(jsonSerialization['chat']),
      bucket:
          serializationManager.deserialize<int>(jsonSerialization['bucket']),
    );
  }

  static final t = ChatMessageTable();

  static const db = ChatMessageRepository._();

  DateTime sentAt;

  String message;

  int senderId;

  _i2.UserPersistent? sender;

  int chatId;

  _i2.Chat? chat;

  int bucket;

  @override
  _i1.Table get table => t;

  ChatMessage copyWith({
    int? id,
    DateTime? sentAt,
    String? message,
    int? senderId,
    _i2.UserPersistent? sender,
    int? chatId,
    _i2.Chat? chat,
    int? bucket,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'sentAt': sentAt.toJson(),
      'message': message,
      'senderId': senderId,
      if (sender != null) 'sender': sender?.toJson(),
      'chatId': chatId,
      if (chat != null) 'chat': chat?.toJson(),
      'bucket': bucket,
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'sentAt': sentAt,
      'message': message,
      'senderId': senderId,
      'chatId': chatId,
      'bucket': bucket,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'sentAt': sentAt.toJson(),
      'message': message,
      'senderId': senderId,
      if (sender != null) 'sender': sender?.allToJson(),
      'chatId': chatId,
      if (chat != null) 'chat': chat?.allToJson(),
      'bucket': bucket,
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
      case 'sentAt':
        sentAt = value;
        return;
      case 'message':
        message = value;
        return;
      case 'senderId':
        senderId = value;
        return;
      case 'chatId':
        chatId = value;
        return;
      case 'bucket':
        bucket = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<ChatMessage>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChatMessageTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    ChatMessageInclude? include,
  }) async {
    return session.db.find<ChatMessage>(
      where: where != null ? where(ChatMessage.t) : null,
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
  static Future<ChatMessage?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChatMessageTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
    ChatMessageInclude? include,
  }) async {
    return session.db.findSingleRow<ChatMessage>(
      where: where != null ? where(ChatMessage.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<ChatMessage?> findById(
    _i1.Session session,
    int id, {
    ChatMessageInclude? include,
  }) async {
    return session.db.findById<ChatMessage>(
      id,
      include: include,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ChatMessageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ChatMessage>(
      where: where(ChatMessage.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    ChatMessage row, {
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
    ChatMessage row, {
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
    ChatMessage row, {
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
    _i1.WhereExpressionBuilder<ChatMessageTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ChatMessage>(
      where: where != null ? where(ChatMessage.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static ChatMessageInclude include({
    _i2.UserPersistentInclude? sender,
    _i2.ChatInclude? chat,
  }) {
    return ChatMessageInclude._(
      sender: sender,
      chat: chat,
    );
  }

  static ChatMessageIncludeList includeList({
    _i1.WhereExpressionBuilder<ChatMessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChatMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChatMessageTable>? orderByList,
    ChatMessageInclude? include,
  }) {
    return ChatMessageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChatMessage.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ChatMessage.t),
      include: include,
    );
  }
}

class _Undefined {}

class _ChatMessageImpl extends ChatMessage {
  _ChatMessageImpl({
    int? id,
    required DateTime sentAt,
    required String message,
    required int senderId,
    _i2.UserPersistent? sender,
    required int chatId,
    _i2.Chat? chat,
    required int bucket,
  }) : super._(
          id: id,
          sentAt: sentAt,
          message: message,
          senderId: senderId,
          sender: sender,
          chatId: chatId,
          chat: chat,
          bucket: bucket,
        );

  @override
  ChatMessage copyWith({
    Object? id = _Undefined,
    DateTime? sentAt,
    String? message,
    int? senderId,
    Object? sender = _Undefined,
    int? chatId,
    Object? chat = _Undefined,
    int? bucket,
  }) {
    return ChatMessage(
      id: id is int? ? id : this.id,
      sentAt: sentAt ?? this.sentAt,
      message: message ?? this.message,
      senderId: senderId ?? this.senderId,
      sender: sender is _i2.UserPersistent? ? sender : this.sender?.copyWith(),
      chatId: chatId ?? this.chatId,
      chat: chat is _i2.Chat? ? chat : this.chat?.copyWith(),
      bucket: bucket ?? this.bucket,
    );
  }
}

class ChatMessageTable extends _i1.Table {
  ChatMessageTable({super.tableRelation}) : super(tableName: 'chatmessage') {
    sentAt = _i1.ColumnDateTime(
      'sentAt',
      this,
    );
    message = _i1.ColumnString(
      'message',
      this,
    );
    senderId = _i1.ColumnInt(
      'senderId',
      this,
    );
    chatId = _i1.ColumnInt(
      'chatId',
      this,
    );
    bucket = _i1.ColumnInt(
      'bucket',
      this,
    );
  }

  late final _i1.ColumnDateTime sentAt;

  late final _i1.ColumnString message;

  late final _i1.ColumnInt senderId;

  _i2.UserPersistentTable? _sender;

  late final _i1.ColumnInt chatId;

  _i2.ChatTable? _chat;

  late final _i1.ColumnInt bucket;

  _i2.UserPersistentTable get sender {
    if (_sender != null) return _sender!;
    _sender = _i1.createRelationTable(
      relationFieldName: 'sender',
      field: ChatMessage.t.senderId,
      foreignField: _i2.UserPersistent.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserPersistentTable(tableRelation: foreignTableRelation),
    );
    return _sender!;
  }

  _i2.ChatTable get chat {
    if (_chat != null) return _chat!;
    _chat = _i1.createRelationTable(
      relationFieldName: 'chat',
      field: ChatMessage.t.chatId,
      foreignField: _i2.Chat.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ChatTable(tableRelation: foreignTableRelation),
    );
    return _chat!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        sentAt,
        message,
        senderId,
        chatId,
        bucket,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'sender') {
      return sender;
    }
    if (relationField == 'chat') {
      return chat;
    }
    return null;
  }
}

@Deprecated('Use ChatMessageTable.t instead.')
ChatMessageTable tChatMessage = ChatMessageTable();

class ChatMessageInclude extends _i1.IncludeObject {
  ChatMessageInclude._({
    _i2.UserPersistentInclude? sender,
    _i2.ChatInclude? chat,
  }) {
    _sender = sender;
    _chat = chat;
  }

  _i2.UserPersistentInclude? _sender;

  _i2.ChatInclude? _chat;

  @override
  Map<String, _i1.Include?> get includes => {
        'sender': _sender,
        'chat': _chat,
      };

  @override
  _i1.Table get table => ChatMessage.t;
}

class ChatMessageIncludeList extends _i1.IncludeList {
  ChatMessageIncludeList._({
    _i1.WhereExpressionBuilder<ChatMessageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChatMessage.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => ChatMessage.t;
}

class ChatMessageRepository {
  const ChatMessageRepository._();

  final attachRow = const ChatMessageAttachRowRepository._();

  Future<List<ChatMessage>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChatMessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChatMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChatMessageTable>? orderByList,
    _i1.Transaction? transaction,
    ChatMessageInclude? include,
  }) async {
    return session.dbNext.find<ChatMessage>(
      where: where?.call(ChatMessage.t),
      orderBy: orderBy?.call(ChatMessage.t),
      orderByList: orderByList?.call(ChatMessage.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<ChatMessage?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChatMessageTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChatMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChatMessageTable>? orderByList,
    _i1.Transaction? transaction,
    ChatMessageInclude? include,
  }) async {
    return session.dbNext.findFirstRow<ChatMessage>(
      where: where?.call(ChatMessage.t),
      orderBy: orderBy?.call(ChatMessage.t),
      orderByList: orderByList?.call(ChatMessage.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<ChatMessage?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ChatMessageInclude? include,
  }) async {
    return session.dbNext.findById<ChatMessage>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<ChatMessage>> insert(
    _i1.Session session,
    List<ChatMessage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<ChatMessage>(
      rows,
      transaction: transaction,
    );
  }

  Future<ChatMessage> insertRow(
    _i1.Session session,
    ChatMessage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<ChatMessage>(
      row,
      transaction: transaction,
    );
  }

  Future<List<ChatMessage>> update(
    _i1.Session session,
    List<ChatMessage> rows, {
    _i1.ColumnSelections<ChatMessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.update<ChatMessage>(
      rows,
      columns: columns?.call(ChatMessage.t),
      transaction: transaction,
    );
  }

  Future<ChatMessage> updateRow(
    _i1.Session session,
    ChatMessage row, {
    _i1.ColumnSelections<ChatMessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.updateRow<ChatMessage>(
      row,
      columns: columns?.call(ChatMessage.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<ChatMessage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<ChatMessage>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    ChatMessage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<ChatMessage>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ChatMessageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<ChatMessage>(
      where: where(ChatMessage.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChatMessageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.count<ChatMessage>(
      where: where?.call(ChatMessage.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ChatMessageAttachRowRepository {
  const ChatMessageAttachRowRepository._();

  Future<void> sender(
    _i1.Session session,
    ChatMessage chatMessage,
    _i2.UserPersistent sender,
  ) async {
    if (chatMessage.id == null) {
      throw ArgumentError.notNull('chatMessage.id');
    }
    if (sender.id == null) {
      throw ArgumentError.notNull('sender.id');
    }

    var $chatMessage = chatMessage.copyWith(senderId: sender.id);
    await session.dbNext.updateRow<ChatMessage>(
      $chatMessage,
      columns: [ChatMessage.t.senderId],
    );
  }

  Future<void> chat(
    _i1.Session session,
    ChatMessage chatMessage,
    _i2.Chat chat,
  ) async {
    if (chatMessage.id == null) {
      throw ArgumentError.notNull('chatMessage.id');
    }
    if (chat.id == null) {
      throw ArgumentError.notNull('chat.id');
    }

    var $chatMessage = chatMessage.copyWith(chatId: chat.id);
    await session.dbNext.updateRow<ChatMessage>(
      $chatMessage,
      columns: [ChatMessage.t.chatId],
    );
  }
}
