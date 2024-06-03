import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/providers/joined_anonymously_provider.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final joinedAnonymouslyProvider =
        Provider.of<JoinedAnonymouslyProvider>(context);
    final TabController tabController = DefaultTabController.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextField(
          decoration: InputDecoration(
            labelText: "Email",
            border: OutlineInputBorder(),
          ),
        ),
        const Padding(padding: EdgeInsets.all(6)),
        const TextField(
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.remove_red_eye),
            labelText: "Password",
            border: OutlineInputBorder(),
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
        Expanded(
          child: Container(),
        ),
        Row(
          children: [
            const Text("Don't have an account? "),
            TextButton(
              onPressed: () {
                tabController.index = 1;
              },
              style: const ButtonStyle(),
              child: const Text("Register Now"),
            )
          ],
        ),
      ],
    );
  }
}
