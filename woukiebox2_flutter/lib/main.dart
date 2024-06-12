import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:window_manager/window_manager.dart';
import 'package:woukiebox2/src/app_bar.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/providers/connection_state_provider.dart';
import 'package:woukiebox2/src/providers/styling_provider.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:woukiebox2/src/app/app.dart';
import 'package:woukiebox2/src/authentication/onboarding.dart';
import 'package:woukiebox2/src/providers/preference_provider.dart';

late SessionManager sessionManager;
late Client client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(610, 456),
      minimumSize: Size(610, 456),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  client = Client(
    'http://localhost:8080/',
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();

  sessionManager = SessionManager(
    caller: client.modules.auth,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => PreferenceProvider(),
      ),
      // Needs preferences
      ChangeNotifierProvider(
        create: (context) => AppStateProvider(context),
      ),
      // Needs app state
      ChangeNotifierProvider(
        create: (context) => ConnectionStateProvider(context),
      ),
      ChangeNotifierProvider(
        create: (context) => StylingProvider(),
      ),
    ],
    child: MyApp(
      future: sessionManager.initialize(),
    ),
  ));
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
    final themeDataProvider = Provider.of<PreferenceProvider>(context);

    return MaterialApp(
      title: 'WoukieBox 2',
      themeMode: themeDataProvider.themeMode,
      theme: ThemeData(
        colorSchemeSeed: themeDataProvider.color,
        fontFamily: 'Fredoka',
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: themeDataProvider.color,
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: 'Fredoka',
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
            return const AppRoot();
          }
        },
      ),
    );
  }
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final appStateProvider = Provider.of<AppStateProvider>(context);

    return Card(
      elevation: 0.5,
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: Border.all(width: 0, color: Colors.transparent),
      margin: const EdgeInsets.all(0),
      child: Column(
        children: [
          const WoukieAppBar(),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              switchInCurve: Curves.elasticOut,
              switchOutCurve: Curves.elasticIn,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return DualTransitionBuilder(
                  reverseBuilder: (context, animation, child) {
                    return SlideTransition(
                      position: Tween(
                        begin: const Offset(0.0, 0.0),
                        end: const Offset(-1.1, 0.0),
                      ).animate(animation),
                      child: child,
                    );
                  },
                  forwardBuilder: (context, animation, child) {
                    return SlideTransition(
                      position: Tween(
                        begin: const Offset(1.1, 0.0),
                        end: const Offset(0.0, 0.0),
                      ).animate(animation),
                      child: child,
                    );
                  },
                  animation: animation,
                  child: child,
                );
              },
              child: (appStateProvider.currentUser != null)
                  ? const App()
                  : const OnboardingScreen(),
            ),
          ),
        ],
      ),
    );
  }
}
