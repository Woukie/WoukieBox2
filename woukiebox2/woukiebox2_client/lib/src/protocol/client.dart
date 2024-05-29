/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:serverpod_auth_client/module.dart' as _i3;
import 'protocol.dart' as _i4;

/// {@category Endpoint}
class EndpointSockets extends _i1.EndpointRef {
  EndpointSockets(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'sockets';

  _i2.Future<String?> getUploadDescription() =>
      caller.callServerEndpoint<String?>(
        'sockets',
        'getUploadDescription',
        {},
      );

  _i2.Future<bool> verifyUpload() => caller.callServerEndpoint<bool>(
        'sockets',
        'verifyUpload',
        {},
      );
}

class _Modules {
  _Modules(Client client) {
    auth = _i3.Caller(client);
  }

  late final _i3.Caller auth;
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
  }) : super(
          host,
          _i4.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
        ) {
    sockets = EndpointSockets(this);
    modules = _Modules(this);
  }

  late final EndpointSockets sockets;

  late final _Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {'sockets': sockets};

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
