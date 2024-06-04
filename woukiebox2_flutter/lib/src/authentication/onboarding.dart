import 'package:flutter/material.dart';
import 'package:woukiebox2/src/app_bar.dart';
import 'package:woukiebox2/src/authentication/register.dart';

import 'login.dart';

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
          WoukieAppBar(),
          SignInPage(),
        ],
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 5,
                child: SizedBox(
                  height: 400,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: const Image(
                          image: AssetImage('assets/black-gay-vitaligo.jpg'),
                        ),
                      ),
                      const SizedBox(
                        width: 328,
                        child: RightScreen(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RightScreen extends StatelessWidget {
  const RightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: TabBarView(
        children: [
          Login(),
          Register(),
        ],
      ),
    );
  }
}
