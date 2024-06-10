class GroupChat {
  final int id;
  List<int> users;
  String name;
  int owner;
  DateTime lastMessage;

  // Built client-side
  final List<dynamic> messages = List.empty(growable: true);

  GroupChat(this.id, this.users, this.name, this.owner, this.lastMessage);
}
