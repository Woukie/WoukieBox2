import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2/src/util/hex_color.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

extension UserUtil on UserClient {
  static UserClient getLoading(BuildContext context, int id) {
    return UserClient(
      id: id,
      username: "Loading...",
      bio: "",
      colour: Theme.of(context).primaryTextTheme.bodyMedium!.color!.toHex(),
      image: "",
      verified: false,
      visible: false,
    );
  }

  // Get or load the user with the associated ID, returns a template user if user doesn't exist.
  static UserClient getUser(BuildContext context, int id) {
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);

    if (appStateProvider.users[id] == null) {
      appStateProvider.scheduleGetUser(id);
      return UserUtil.getLoading(context, id);
    }

    return appStateProvider.users[id]!;
  }
}
