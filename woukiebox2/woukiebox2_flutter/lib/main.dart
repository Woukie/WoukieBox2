import 'dart:async';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:woukiebox2_flutter/src/app/app.dart';
import 'package:woukiebox2_flutter/src/authentication/onboarding.dart';
import 'package:woukiebox2_flutter/src/providers/theme_data_provider.dart';

late SessionManager sessionManager;
late Client client;
final isMaximized = ValueNotifier<bool>(false);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  client = Client(
    'http://$localhost:8080/',
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();

  sessionManager = SessionManager(
    caller: client.modules.auth,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => ThemeDataProvider(),
    child: MyApp(future: sessionManager.initialize()),
  ));

  doWhenWindowReady(() {
    const initialSize = Size(600, 450);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "WoukieBox 2";
    appWindow.show();
  });
}

class MyApp extends StatefulWidget {
  final Future future;

  const MyApp({super.key, required this.future});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    sessionManager.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    sessionManager.removeListener(() {
      setState(() {});
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeDataProvider = Provider.of<ThemeDataProvider>(context);
    return MaterialApp(
      title: 'WoukieBox 2',
      themeMode: themeDataProvider.themeMode,
      theme: ThemeData(
        colorSchemeSeed: themeDataProvider.color,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: themeDataProvider.color,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: FutureBuilder(
        future: widget.future,
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
