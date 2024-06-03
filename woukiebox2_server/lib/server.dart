import 'dart:math';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:serverpod/serverpod.dart';

import 'package:woukiebox2_server/src/web/routes/root.dart';
import 'package:serverpod_auth_server/module.dart' as auth;

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';

void run(List<String> args) async {
  final Random random = Random();

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

      final gmailEmail = session.serverpod.getPassword('gmailEmail')!;
      final gmailPassword = session.serverpod.getPassword('gmailPassword')!;

      final smtpServer = gmail(gmailEmail, gmailPassword);
      final message = Message()
        ..from = Address(gmailEmail, "Woukie's Goon")
        ..recipients = [email]
        ..subject = "Verification Code for WoukieBox2"
        ..html = validationCode;

      try {
        await send(message, smtpServer);
        return true;
      } on MailerException catch (e) {
        print(e);
      }

      return false;
    },
    sendPasswordResetEmail: (session, userInfo, validationCode) async {
      print('Validation code: $validationCode');
      return true;
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
