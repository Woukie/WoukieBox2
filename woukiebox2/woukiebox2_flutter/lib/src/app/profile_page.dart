import 'dart:io';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:woukiebox2_flutter/main.dart';
import 'package:woukiebox2_flutter/src/providers/connection_state_provider.dart';
import 'package:woukiebox2_flutter/src/util/hex_color.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Color nameColor;

  @override
  Widget build(BuildContext context) {
    final connectionProvider = Provider.of<ConnectionStateProvider>(context);
    final User? user = connectionProvider.users[connectionProvider.currentUser];

    if (user == null) return const Text("Unknown User");

    nameColor = HexColor.fromHex(user.colour);

    final nameController = TextEditingController(text: user.username);
    final bioController = TextEditingController(text: user.bio);

    return Wrap(
      children: [
        Container(
          width: 250,
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: CircleAvatar(
                      foregroundImage: NetworkImage(
                        user.image,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 0,
                      child: Row(
                        children: [
                          Expanded(
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
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: IconButton(
                              onPressed: () async {
                                nameColor = await showColorPickerDialog(
                                  context,
                                  nameColor,
                                  pickersEnabled: <ColorPickerType, bool>{
                                    ColorPickerType.wheel: true,
                                    ColorPickerType.accent: false,
                                    ColorPickerType.primary: false,
                                  },
                                  enableShadesSelection: false,
                                );
                              },
                              icon: const Icon(Icons.brush),
                            ),
                          ),
                        ],
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
                            bio: bioController.text != user.bio
                                ? bioController.text
                                : null,
                            username: nameController.text != user.username
                                ? nameController.text
                                : null,
                            colour: nameColor.hex != user.colour
                                ? nameColor.hex
                                : null,
                          ),
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

  void uploadPfp() async {
    var uploadDescription = await client.sockets.getUploadDescription();

    var file = File("files\\image.png");
    final uint8list = await file.readAsBytes();
    final byteData = uint8list.buffer.asByteData();

    // print("File location");
    // print(file.absolute.path);

    if (uploadDescription != null) {
      var uploader = FileUploader(uploadDescription);

      await uploader.uploadByteData(byteData);
      await client.sockets.verifyUpload();
    }
  }
}
