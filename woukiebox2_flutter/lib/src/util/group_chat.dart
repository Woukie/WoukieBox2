class GroupChat {
  final int id;
  List<int> users;
  List<int> owners;
  String name;
  int creator;
  DateTime lastMessage;

  // Built client-side
  final List<dynamic> messages = List.empty(growable: true);

  GroupChat(
    this.id,
    this.users,
    this.name,
    this.owners,
    this.creator,
    this.lastMessage,
  );
}
