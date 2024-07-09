

class AdminNotificationModel {
  final int id; // Add id field
  final String source;
  final DateTime timestamp;
  final String header;
  final String subheader;

  AdminNotificationModel({
    required this.id,
    required this.source,
    required this.timestamp,
    required this.header,
    required this.subheader,
  });
}
