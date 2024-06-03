import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:woukiebox2/main.dart';
import 'package:woukiebox2/src/providers/connection_state_provider.dart';

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

  String? _emailError;
  String? _passwordError;

  late final EmailAuthController _emailAuth;

  @override
  void initState() {
    super.initState();
    _emailAuth = EmailAuthController(client.modules.auth);
  }

  @override
  Widget build(BuildContext context) {
    final connectionStateProvider =
        Provider.of<ConnectionStateProvider>(context);
    final TabController tabController = DefaultTabController.of(context);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _emailController,
            enabled: _enabled,
            decoration: InputDecoration(
              errorText: _emailError,
              labelText: "Email",
              border: const OutlineInputBorder(),
            ),
            onChanged: (_) {
              _validateEmail();
            },
          ),
          const Padding(padding: EdgeInsets.all(6)),
          TextField(
            controller: _passwordController,
            enabled: _enabled,
            obscureText: true,
            decoration: InputDecoration(
              errorText: _passwordError,
              suffixIcon: const Icon(Icons.remove_red_eye),
              labelText: "Password",
              border: const OutlineInputBorder(),
            ),
            onChanged: (_) {
              _validatePassword();
            },
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
                          connectionStateProvider.setJoinedAnonymously(true);
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

  // Todo: duplicate code. combine with register
  bool _validateEmail() {
    var email = _emailController.text.trim().toLowerCase();
    if (!EmailValidator.validate(email)) {
      setState(() {
        _emailError = "Invalid email";
      });

      return false;
    }

    setState(() {
      _emailError = null;
    });
    return true;
  }

  bool _validatePassword() {
    var password = _passwordController.text;
    if (password.length < 5) {
      setState(() {
        _passwordError = "Minimum of 5 characters";
      });

      return false;
    }

    if (password.length > 25) {
      setState(() {
        _passwordError = "Maximum of 25 characters";
      });

      return false;
    }

    setState(() {
      _passwordError = null;
    });
    return true;
  }

  Future<void> _signIn() async {
    var email = _emailController.text.trim().toLowerCase();
    var password = _passwordController.text;

    if (!(_validateEmail() && _validatePassword())) return;

    setState(() {
      _enabled = false;
    });

    var result = await _emailAuth.signIn(email, password);
    if (result == null) {
      setState(() {
        _passwordError = 'Incorrect password';
        _enabled = true;
      });
      return;
    }
  }
}
