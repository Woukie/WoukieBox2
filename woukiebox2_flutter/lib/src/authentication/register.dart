import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({
    super.key,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    final TabController tabController = DefaultTabController.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Sign up to WoukieBox2"),
        const Padding(padding: EdgeInsets.all(6)),
        const TextField(
          decoration: InputDecoration(
            labelText: "Username",
            border: OutlineInputBorder(),
          ),
        ),
        const Padding(padding: EdgeInsets.all(6)),
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
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: () {},
                child: const Text("Sign up"),
              ),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.all(6)),
        Row(
          children: [
            const Text("Already have an account? "),
            TextButton(
              onPressed: () {
                tabController.index = 0;
              },
              style: const ButtonStyle(),
              child: const Text("Login Now"),
            )
          ],
        ),
      ],
    );
  }
}
