// notification_model.dart


class NotificationModel {
  final int id; // Add id field
  final String source;
  final DateTime timestamp;
  final String header;
  final String subheader;

  NotificationModel({
    required this.id,
    required this.source,
    required this.timestamp,
    required this.header,
    required this.subheader,
  });
}
