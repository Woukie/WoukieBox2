/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class LastViewedServer extends _i1.SerializableEntity {
  LastViewedServer._({required this.viewedData});

  factory LastViewedServer({required Map<int, DateTime> viewedData}) =
      _LastViewedServerImpl;

  factory LastViewedServer.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return LastViewedServer(
        viewedData: serializationManager
            .deserialize<Map<int, DateTime>>(jsonSerialization['viewedData']));
  }

  Map<int, DateTime> viewedData;

  LastViewedServer copyWith({Map<int, DateTime>? viewedData});
  @override
  Map<String, dynamic> toJson() {
    return {'viewedData': viewedData.toJson(valueToJson: (v) => v.toJson())};
  }
}

class _LastViewedServerImpl extends LastViewedServer {
  _LastViewedServerImpl({required Map<int, DateTime> viewedData})
      : super._(viewedData: viewedData);

  @override
  LastViewedServer copyWith({Map<int, DateTime>? viewedData}) {
    return LastViewedServer(viewedData: viewedData ?? this.viewedData.clone());
  }
}
