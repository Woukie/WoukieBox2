import 'dart:async';

import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:woukiebox2_flutter/app.dart';
import 'package:woukiebox2_flutter/onboarding.dart';

late SessionManager sessionManager;
late Client client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  client = Client(
    'http://$localhost:8080/',
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();

  sessionManager = SessionManager(
    caller: client.modules.auth,
  );

  runApp(MyApp(future: sessionManager.initialize()));
}

class MyApp extends StatelessWidget {
  final Future future;

  const MyApp({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WoukieBox 2',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return sessionManager.isSignedIn
                ? const App()
                : const OnboardingScreen();
          }
        },
      ),
    );
  }
}
