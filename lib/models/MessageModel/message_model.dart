class MessageModel {
  String sender;
  String receiver;
  String content;
  DateTime timestamp;

  MessageModel({
    required this.sender,
    required this.receiver,
    required this.content,
    required this.timestamp,
  });
}
