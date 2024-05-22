import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:woukiebox2_flutter/main.dart';
import 'package:woukiebox2_flutter/src/authentication/onboarding_app_bar.dart';
import 'package:woukiebox2_flutter/src/providers/connection_state_provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: Border.all(width: 0, color: Colors.transparent),
      margin: const EdgeInsets.all(0),
      child: const Column(
        children: [
          OnboardingAppBar(),
          SignInPage(),
        ],
      ),
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({
    super.key,
  });

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final connectionProvider =
          Provider.of<ConnectionStateProvider>(context, listen: false);
      if (connectionProvider.state != ConnectionState.none) {
        connectionProvider.closeConnection();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SignInWithEmailButton(
        caller: client.modules.auth,
      ),
    );
  }
}
