class GroupChat {
  final int id; // Sent with "message" messages to indicate target
  String image = ""; // TODO: Long time in the future probably
  String name;

  // Built client-side
  final List<dynamic> messages = List.empty(growable: true);

  GroupChat(this.id, this.name);
}
