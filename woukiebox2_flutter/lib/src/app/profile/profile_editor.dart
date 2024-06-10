import 'package:file_selector/file_selector.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/main.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';
import 'package:woukiebox2/src/app/profile/profile_pic.dart';
import 'package:woukiebox2/src/util/hex_color.dart';

// Wraps a child in a gesture detector that opens the profile editor when clicked on
class ProfileEditor extends StatelessWidget {
  const ProfileEditor({
    super.key,
    required this.user,
    required this.child,
  });

  final UserClient user;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      onTapDown: (TapDownDetails details) async {
        final screenSize = MediaQuery.of(context).size;
        Offset offset = details.globalPosition;

        await showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            offset.dx,
            offset.dy,
            screenSize.width - offset.dx,
            screenSize.height - offset.dy,
          ),
          items: [
            PopupMenuItem(
              enabled: false,
              child: EditorWidget(
                user: user,
                child: child,
              ),
            ),
          ],
          elevation: 8.0,
        );
      },
      child: child,
    );
  }
}

class EditorWidget extends StatefulWidget {
  const EditorWidget({super.key, required this.user, required this.child});

  final UserClient user;
  final Widget child;

  @override
  State<EditorWidget> createState() => _EditorWidgetState();
}

class _EditorWidgetState extends State<EditorWidget> {
  TextEditingController? nameController;
  TextEditingController? bioController;

  Color? nameColor;
  String newImage = "";

  @override
  Widget build(BuildContext context) {
    final appStateProvider = Provider.of<AppStateProvider>(context);
    // User is never null as app is conditionally rendered based on user null check
    final UserClient user =
        appStateProvider.users[appStateProvider.currentUser]!;

    nameController ??= TextEditingController(text: user.username);
    bioController ??= TextEditingController(text: user.bio);

    TextStyle textStyle = Theme.of(context).primaryTextTheme.bodyMedium!;

    return SizedBox(
      width: 200,
      height: 250,
      child: Padding(
        // Unify the padding from the stock popup
        padding: const EdgeInsets.only(top: 3, bottom: 3),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: user.verified ? chooseProfilePicture : null,
                  child: ProfilePic(
                    url: newImage == "" ? user.image : (newImage),
                    local: !kIsWeb && newImage != "",
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: TextField(
                                controller: nameController,
                                style: textStyle.copyWith(
                                  color: nameColor ??
                                      HexColor.fromHex(widget.user.colour),
                                ),
                                decoration: const InputDecoration(
                                  hintText: "Name...",
                                  border: InputBorder.none,
                                ),
                                // So the save button can enable itself
                                onChanged: (_) {
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 4.0,
                            ),
                            child: IconButton(
                              onPressed: () async {
                                Color chosenColor = await showColorPickerDialog(
                                  context,
                                  nameColor ?? HexColor.fromHex(user.colour),
                                  pickersEnabled: <ColorPickerType, bool>{
                                    ColorPickerType.wheel: true,
                                    ColorPickerType.accent: false,
                                    ColorPickerType.primary: false,
                                  },
                                  enableShadesSelection: false,
                                );

                                setState(() {
                                  nameColor = chosenColor;
                                });
                              },
                              icon: const Icon(Icons.brush),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      children: [
                        Expanded(
                          child: TextField(
                            scrollPadding: EdgeInsets.zero,
                            style: TextStyle(fontSize: textStyle.fontSize),
                            // So the save button can enable itself
                            onChanged: (_) {
                              setState(() {});
                            },
                            controller: bioController,
                            maxLines: 10,
                            decoration: const InputDecoration(
                              hintText: "Bio...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "#${widget.user.id}",
                    ),
                  ),
                  FilledButton(
                    onPressed: nameColor != null ||
                            newImage != "" ||
                            nameController!.text != user.username ||
                            bioController!.text != user.bio
                        ? () {
                            updateProfile(user);
                          }
                        : null,
                    child: const Text("Save"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void uploadPfp(String path) async {
    var uploadDescription = await client.profilePicture.getUploadDescription();

    var file = XFile(path);
    final uint8list = await file.readAsBytes();
    final byteData = uint8list.buffer.asByteData();

    if (uploadDescription != null) {
      var uploader = FileUploader(uploadDescription);

      await uploader.uploadByteData(byteData);
      await client.profilePicture.verifyUpload();
    }
  }

  void chooseProfilePicture() async {
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'images',
      extensions: <String>['jpg', 'png'],
    );
    final XFile? file =
        await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

    setState(() {
      newImage = file?.path ?? "";
    });
  }

  void updateProfile(UserClient originalUser) async {
    client.sockets.sendStreamMessage(
      UpdateProfileClient(
        bio: bioController?.text != originalUser.bio
            ? bioController?.text
            : null,
        username: nameController?.text != originalUser.username
            ? nameController?.text
            : null,
        colour: nameColor?.hex != originalUser.colour ? nameColor?.hex : null,
      ),
    );

    if (newImage != "") {
      uploadPfp(newImage);
    }

    Navigator.pop(context);
  }
}
