import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:woukiebox2/main.dart';
import 'package:woukiebox2/src/providers/joined_anonymously_provider.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _enabled = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late final EmailAuthController _emailAuth;

  @override
  void initState() {
    super.initState();
    _emailAuth = EmailAuthController(client.modules.auth);
  }

  @override
  Widget build(BuildContext context) {
    final joinedAnonymouslyProvider =
        Provider.of<JoinedAnonymouslyProvider>(context);
    final TabController tabController = DefaultTabController.of(context);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _emailController,
            enabled: _enabled,
            decoration: const InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          const Padding(padding: EdgeInsets.all(6)),
          TextField(
            controller: _passwordController,
            enabled: _enabled,
            obscureText: true,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.remove_red_eye),
              labelText: "Password",
              border: OutlineInputBorder(),
            ),
          ),
          const Padding(padding: EdgeInsets.all(6)),
          const Text("Forgot password? well fuck off then"),
          const Padding(padding: EdgeInsets.all(6)),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: _enabled ? _signIn : null,
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
                  onPressed: _enabled
                      ? () {
                          joinedAnonymouslyProvider.setJoined(true);
                        }
                      : null,
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
                onPressed: _enabled
                    ? () {
                        tabController.index = 1;
                      }
                    : null,
                style: const ButtonStyle(),
                child: const Text("Register Now"),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _signIn() async {
    setState(() {
      _enabled = false;
    });

    var email = _emailController.text.trim().toLowerCase();
    var password = _passwordController.text;

    await _emailAuth.signIn(email, password);

    setState(() {
      _enabled = true;
    });
  }
}
