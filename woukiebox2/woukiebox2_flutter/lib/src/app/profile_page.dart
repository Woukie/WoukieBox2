import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:woukiebox2_flutter/main.dart';
import 'package:woukiebox2_flutter/src/providers/connection_state_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final User? user;

    final connectionStateProvider =
        Provider.of<ConnectionStateProvider>(context);

    user = connectionStateProvider.users[connectionStateProvider.currentUser];

    final nameController = TextEditingController(text: user?.username);
    final bioController = TextEditingController(text: user?.bio);

    return Wrap(
      children: [
        Container(
          width: 250,
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: CircleAvatar(),
                  ),
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            hintText: "Name...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextField(
                      controller: bioController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: "Bio...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: () {
                        client.sockets.sendStreamMessage(
                          UpdateProfile(
                              username: nameController.text,
                              bio: bioController.text,
                              colour: "#FF0000"),
                        );
                      },
                      child: const Text("Update"),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
