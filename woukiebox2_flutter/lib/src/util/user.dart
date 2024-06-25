import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/util/hex_color.dart';

class User {
  final int id;
  String username, bio, colour, image;
  bool visible, verified;

  User({
    required this.id,
    required this.username,
    required this.bio,
    required this.colour,
    required this.image,
    required this.visible,
    required this.verified,
  });

  Color getColor() {
    return HexColor.fromHex(colour);
  }

  static User _getLoading(BuildContext context, int id) {
    return User(
      id: id,
      username: "Loading...",
      bio: "",
      colour: Theme.of(context).primaryTextTheme.bodyMedium!.color!.toHex(),
      image: "",
      verified: false,
      visible: false,
    );
  }

  /// Get or load the user with the associated ID.
  ///
  /// Returns the user, or a template user if user doesn't exist.
  static User getUser(BuildContext context, int id) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);

    if (appStateProvider.users[id] == null) {
      appStateProvider.scheduleGetUser(id);
      return _getLoading(context, id);
    }

    return appStateProvider.users[id]!;
  }
}
