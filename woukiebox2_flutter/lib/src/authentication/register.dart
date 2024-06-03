import 'package:flutter/material.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:email_validator/email_validator.dart';
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

  String? _usernameError;
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
    final TabController tabController = DefaultTabController.of(context);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            enabled: _enabled,
            controller: _usernameController,
            decoration: InputDecoration(
              errorText: _usernameError,
              labelText: "Username",
              border: const OutlineInputBorder(),
            ),
            onChanged: (_) {
              _validateUsername();
            },
          ),
          const Padding(padding: EdgeInsets.all(6)),
          TextField(
            enabled: _enabled,
            controller: _emailController,
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
            enabled: _enabled,
            obscureText: true,
            controller: _passwordController,
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

  bool _validateUsername() {
    var userName = _usernameController.text.trim();
    if (userName.isEmpty) {
      setState(() {
        _usernameError = "Please enter a user name";
      });

      return false;
    }

    setState(() {
      _usernameError = null;
    });
    return true;
  }

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

  Future<void> _createAccount() async {
    var username = _usernameController.text.trim();
    var email = _emailController.text.trim().toLowerCase();
    var password = _passwordController.text;

    if (!(_validateUsername() && _validateEmail() && _validatePassword())) {
      return;
    }

    setState(() {
      _enabled = false;
    });

    var success = await _emailAuth.createAccountRequest(
      username,
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

  Future<void> _confirmEmailDialoge(context) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        String? validationCodeError;

        bool validateValidationCode() {
          var code = _validationCodeController.text;
          if (!RegExp(r"^[0-9]{8}$").hasMatch(code)) {
            setState(() {
              validationCodeError = "Codes are 8 numbers long";
            });

            return false;
          }

          setState(() {
            validationCodeError = null;
          });
          return true;
        }

        return StatefulBuilder(
          builder: (context, setState) {
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
                decoration: InputDecoration(
                  errorText: validationCodeError,
                  labelText: 'Verification code',
                  helperText: 'Enter the code we sent to your inbox',
                  border: const OutlineInputBorder(),
                ),
                onChanged: (_) {
                  validateValidationCode();
                  setState(() {});
                },
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
