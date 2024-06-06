/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/crud.dart' as _i2;
import '../endpoints/profile_picture.dart' as _i3;
import '../endpoints/sockets.dart' as _i4;
import 'package:serverpod_auth_server/module.dart' as _i5;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'crud': _i2.CrudEndpoint()
        ..initialize(
          server,
          'crud',
          null,
        ),
      'profilePicture': _i3.ProfilePictureEndpoint()
        ..initialize(
          server,
          'profilePicture',
          null,
        ),
      'sockets': _i4.SocketsEndpoint()
        ..initialize(
          server,
          'sockets',
          null,
        ),
    };
    connectors['crud'] = _i1.EndpointConnector(
      name: 'crud',
      endpoint: endpoints['crud']!,
      methodConnectors: {
        'getUser': _i1.MethodConnector(
          name: 'getUser',
          params: {
            'targetId': _i1.ParameterDescription(
              name: 'targetId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['crud'] as _i2.CrudEndpoint).getUser(
            session,
            params['targetId'],
          ),
        )
      },
    );
    connectors['profilePicture'] = _i1.EndpointConnector(
      name: 'profilePicture',
      endpoint: endpoints['profilePicture']!,
      methodConnectors: {
        'getUploadDescription': _i1.MethodConnector(
          name: 'getUploadDescription',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['profilePicture'] as _i3.ProfilePictureEndpoint)
                  .getUploadDescription(session),
        ),
        'verifyUpload': _i1.MethodConnector(
          name: 'verifyUpload',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['profilePicture'] as _i3.ProfilePictureEndpoint)
                  .verifyUpload(session),
        ),
      },
    );
    connectors['sockets'] = _i1.EndpointConnector(
      name: 'sockets',
      endpoint: endpoints['sockets']!,
      methodConnectors: {},
    );
    modules['serverpod_auth'] = _i5.Endpoints()..initializeEndpoints(server);
  }
}
