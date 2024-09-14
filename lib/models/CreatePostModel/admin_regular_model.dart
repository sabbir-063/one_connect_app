// admin_regular_model.dart
import 'package:intl/intl.dart';

class AdminRegularModel {
  String id; // New field for document ID
  final String userId;
  final String profileName;
  final String profilePicUrl;
  final String timeAgo;
  final String postMessage;
  final List<String> imageUrls;

  AdminRegularModel({
    this.id = '', // Default to empty string
    required this.userId,
    required this.profileName,
    required this.profilePicUrl,
    required this.timeAgo,
    required this.postMessage,
    required this.imageUrls,
  });

  DateTime get timestamp {
    return DateFormat('dd/MM/yyyy hh:mm a').parse(timeAgo);
  }

  // Convert AdminPostModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'profileName': profileName,
      'profilePicUrl': profilePicUrl,
      'timeAgo': timeAgo,
      'postMessage': postMessage,
      'imageUrls': imageUrls,
    };
  }

  // Create an AdminPostModel instance from a map
  factory AdminRegularModel.fromMap(Map<String, dynamic> map) {
    return AdminRegularModel(
      userId: map['userId'],
      profileName: map['profileName'],
      profilePicUrl: map['profilePicUrl'],
      timeAgo: map['timeAgo'],
      postMessage: map['postMessage'],
      imageUrls: List<String>.from(map['imageUrls']),
    );
  }
}
