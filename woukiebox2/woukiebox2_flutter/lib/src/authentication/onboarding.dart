import 'package:flutter/material.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:woukiebox2_flutter/main.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authenticate"),
      ),
      body: Center(
        child: SignInWithEmailButton(
          caller: client.modules.auth,
        ),
      ),
    );
  }
}
