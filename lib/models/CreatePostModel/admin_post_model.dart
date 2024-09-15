// admin_post_model.dart
import 'package:intl/intl.dart';

class AdminPostModel {
  String id; // New field for document ID
  final String userId;
  final String profileName;
  final String profilePicUrl;
  final String timeAgo;
  final String postMessage;
  final int donationNeeded;
  final int donationRaised; // New field for donation raised
  final List<String> imageUrls;
  final bool postAccepted;
  final bool adminChecked;

  AdminPostModel({
    this.id = '', // Default to empty string
    required this.userId,
    required this.profileName,
    required this.profilePicUrl,
    required this.timeAgo,
    required this.postMessage,
    required this.donationNeeded,
    this.donationRaised = 0, // Default value for donationRaised
    required this.imageUrls,
    this.postAccepted = false,
    this.adminChecked = false,
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
      'donationNeeded': donationNeeded,
      'donationRaised': donationRaised, // New field in toMap
      'imageUrls': imageUrls,
      'postAccepted': postAccepted,
      'adminChecked': adminChecked,
    };
  }

  // Create an AdminPostModel instance from a map
  factory AdminPostModel.fromMap(Map<String, dynamic> map) {
    return AdminPostModel(
      userId: map['userId'],
      profileName: map['profileName'],
      profilePicUrl: map['profilePicUrl'],
      timeAgo: map['timeAgo'],
      postMessage: map['postMessage'],
      donationNeeded: map['donationNeeded'],
      donationRaised: map['donationRaised'], // New field in fromMap
      imageUrls: List<String>.from(map['imageUrls']),
      postAccepted: map['postAccepted'],
      adminChecked: map['adminChecked'],
    );
  }
}
