import 'package:flutter/material.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:woukiebox2/main.dart';

class Register extends StatefulWidget {
  const Register({
    super.key,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _enabled = true;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _validationCodeController =
      TextEditingController();

  late final EmailAuthController _emailAuth;

  @override
  void initState() {
    super.initState();
    _emailAuth = EmailAuthController(client.modules.auth);
  }

  @override
  Widget build(BuildContext context) {
    final TabController tabController = DefaultTabController.of(context);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            enabled: _enabled,
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: "Username",
              border: OutlineInputBorder(),
            ),
          ),
          const Padding(padding: EdgeInsets.all(6)),
          TextField(
            enabled: _enabled,
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          const Padding(padding: EdgeInsets.all(6)),
          TextField(
            enabled: _enabled,
            obscureText: true,
            controller: _passwordController,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.remove_red_eye),
              labelText: "Password",
              border: OutlineInputBorder(),
            ),
          ),
          const Padding(padding: EdgeInsets.all(6)),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: _enabled ? _createAccount : null,
                  child: const Text("Sign up"),
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
              const Text("Already have an account? "),
              TextButton(
                onPressed: _enabled
                    ? () {
                        tabController.index = 0;
                      }
                    : null,
                style: const ButtonStyle(),
                child: const Text("Login Now"),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _createAccount() async {
    setState(() {
      _enabled = false;
    });

    var userName = _usernameController.text.trim();
    var email = _emailController.text.trim().toLowerCase();
    var password = _passwordController.text;

    var success = await _emailAuth.createAccountRequest(
      userName,
      email,
      password,
    );

    setState(() {
      _enabled = true;

      if (success) {
        _confirmEmailDialoge(context);
      }
    });
  }

  Future<void> _confirmEmailDialoge(BuildContext context) {
    final TextEditingController _validationCodeController =
        TextEditingController();

    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          contentPadding: const EdgeInsets.all(8),
          actionsPadding: const EdgeInsets.only(bottom: 8, right: 8),
          content: TextField(
            enabled: _enabled,
            controller: _validationCodeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Verification code',
              helperText: 'Enter the code we sent to your inbox',
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: _enabled
                  ? () {
                      Navigator.of(context).pop();
                    }
                  : null,
              child: const Text('Cancel'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: _enabled ? _validateAccount : null,
              child: const Text('Verify'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _validateAccount() async {
    var email = _emailController.text.toLowerCase().trim();

    setState(() {
      _enabled = false;
    });

    var userInfo = await _emailAuth.validateAccount(
      email,
      _validationCodeController.text,
    );

    var result = await _emailAuth.signIn(email, _passwordController.text);
    if (result == null) {
      setState(() {
        _enabled = true;
      });
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}
