import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String sender;
  String content;
  DateTime timestamp;

  MessageModel({
    required this.sender,
    required this.content,
    required this.timestamp,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      sender: map['sender'],
      content: map['content'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'content': content,
      'timestamp': timestamp,
    };
  }
}
