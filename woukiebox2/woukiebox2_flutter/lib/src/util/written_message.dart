// Helps to preserve state of message without having to send additional data per message.
class WrittenMessage {
  final int senderId;
  final String username;
  final String colour;
  final String message;

  WrittenMessage(this.senderId, this.username, this.message, this.colour);
}
