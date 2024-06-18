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

abstract class LastReadServer extends _i1.SerializableEntity {
  LastReadServer._({required this.readData});

  factory LastReadServer({required Map<int, DateTime> readData}) =
      _LastReadServerImpl;

  factory LastReadServer.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return LastReadServer(
        readData: serializationManager
            .deserialize<Map<int, DateTime>>(jsonSerialization['readData']));
  }

  Map<int, DateTime> readData;

  LastReadServer copyWith({Map<int, DateTime>? readData});
  @override
  Map<String, dynamic> toJson() {
    return {'readData': readData.toJson(valueToJson: (v) => v.toJson())};
  }

  @override
  Map<String, dynamic> allToJson() {
    return {'readData': readData.toJson(valueToJson: (v) => v.toJson())};
  }
}

class _LastReadServerImpl extends LastReadServer {
  _LastReadServerImpl({required Map<int, DateTime> readData})
      : super._(readData: readData);

  @override
  LastReadServer copyWith({Map<int, DateTime>? readData}) {
    return LastReadServer(readData: readData ?? this.readData.clone());
  }
}
