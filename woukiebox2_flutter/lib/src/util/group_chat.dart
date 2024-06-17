import 'dart:math';

import 'package:woukiebox2/src/providers/app_state_provider.dart';
import 'package:woukiebox2_client/woukiebox2_client.dart';

class GroupChat {
  final int id, creator;
  List<int> users, owners;
  String name;
  DateTime lastMessage;

  // Supports any type from written_message. Use WrittenChatMessage over WrittenGlobalMessage to display the latest user data
  final List<dynamic> messages = List.empty(growable: true);
  final List<int> bucketsLoading = List.empty(growable: true);

  GroupChat(
    this.id,
    this.users,
    this.name,
    this.owners,
    this.creator,
    this.lastMessage,
  );

  static String generateGroupName(
      GroupChat groupChat, AppStateProvider appStateProvider) {
    List<int> members = groupChat.users
        .where((user) => user != appStateProvider.currentUser)
        .toList();

    String name = "";
    for (int i = 0; i < min(members.length, 3); i++) {
      int member = members[i];
      UserClient? user = appStateProvider.users[member];
      if (user == null) appStateProvider.scheduleGetUser(member);
      name += "${user?.username ?? "Loading..."}, ";
    }

    if (name.isEmpty) {
      name = "Lonely Chat";
    } else {
      name = name.substring(0, name.length - 2);
    }

    return name;
  }
}
