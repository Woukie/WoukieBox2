import 'package:serverpod/serverpod.dart';

import 'package:woukiebox2_server/src/web/routes/root.dart';
import 'package:serverpod_auth_server/module.dart' as auth;

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';

void run(List<String> args) async {
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
  );

  auth.AuthConfig.set(auth.AuthConfig(
    minPasswordLength: 5,
    maxPasswordLength: 25,
    sendValidationEmail: (session, email, validationCode) async {
      print('Validation code: $validationCode');
      return true;
    },
    sendPasswordResetEmail: (session, userInfo, validationCode) async {
      print('Validation code: $validationCode');
      return true;
    },
    onUserCreated: (session, userInfo) async {
      await UserPersistent.db.insertRow(
        session,
        UserPersistent(
          userInfoId: userInfo.id!,
          color: "FF0000",
          image: "",
          bio: "",
        ),
      );
    },
  ));

  pod.webServer.addRoute(RouteRoot(), '/');
  pod.webServer.addRoute(RouteRoot(), '/index.html');

  pod.webServer.addRoute(
    RouteStaticDirectory(serverDirectory: 'static', basePath: '/'),
    '/*',
  );

  await pod.start();
}
