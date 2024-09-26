// notification_model.dart

class NotificationModel {
  String id;
  String title;
  String message;
  DateTime timeStamp;
  bool isRead;

  NotificationModel({
    this.id = '',
    required this.title,
    required this.message,
    required this.timeStamp,
    this.isRead = false, // Default value, marking the notification as unread
  });

  // Convert notification to Map (for Firestore storage)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'timeStamp': timeStamp.toIso8601String(),
      'isRead': isRead,
    };
  }

  // Convert Firestore data to NotificationModel
  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as String,
      title: map['title'] as String,
      message: map['message'] as String,
      timeStamp: DateTime.parse(map['timeStamp'] as String),
      isRead: map['isRead'] as bool? ?? false,
    );
  }
}
