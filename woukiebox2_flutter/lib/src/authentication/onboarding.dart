import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/authentication/onboarding_app_bar.dart';
import 'package:woukiebox2/src/providers/joined_anonymously_provider.dart';

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
  final TextEditingController _controllerOutlined = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final joinedAnonymouslyProvider =
        Provider.of<JoinedAnonymouslyProvider>(context);

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
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: const Image(
                        image: AssetImage('assets/black-gay-vitaligo.jpg'),
                      ),
                    ),
                    SizedBox(
                      width: 350,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Log in to WoukieBox2"),
                            const Padding(padding: EdgeInsets.all(6)),
                            const TextField(
                              decoration: InputDecoration(
                                labelText: "Email",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.all(6)),
                            TextField(
                              decoration: InputDecoration(
                                suffixIcon: _HideButton(
                                    controller: _controllerOutlined),
                                labelText: "Password",
                                border: const OutlineInputBorder(),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.all(6)),
                            const Text("Forgot password?"),
                            const Padding(padding: EdgeInsets.all(6)),
                            Row(
                              children: [
                                Expanded(
                                  child: FilledButton(
                                    onPressed: () {},
                                    child: const Text("Log in"),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.all(6)),
                            const Row(
                              children: [
                                Expanded(child: Divider()),
                                Padding(
                                  padding: EdgeInsets.only(left: 12, right: 12),
                                  child: Text("Or"),
                                ),
                                Expanded(child: Divider()),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.all(6)),
                            Row(
                              children: [
                                Expanded(
                                  child: FilledButton.tonalIcon(
                                    icon: const Icon(Icons.theater_comedy),
                                    onPressed: () {
                                      joinedAnonymouslyProvider.setJoined(true);
                                    },
                                    label: const Text("Join Anonymously"),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.all(6)),
                            Row(
                              children: [
                                const Text("Don't have an account? "),
                                TextButton(
                                  onPressed: () {},
                                  style: const ButtonStyle(),
                                  child: const Text("Register Now"),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HideButton extends StatelessWidget {
  const _HideButton({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: IconButton(
          icon: const Icon(Icons.remove_red_eye),
          onPressed: () => controller.clear(),
        ),
      );
}
