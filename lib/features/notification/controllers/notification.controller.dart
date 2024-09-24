import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../models/notificationModel/notification_model.dart';

class NotificationController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to send notification to all users
  Future<void> sendNotificationToAll(String title, String message) async {
    try {
      final usersSnapshot = await _firestore.collection('Users').get();
      const adminEmail = 'admin@gmail.com'; // Admin email
      final String notificationId = const Uuid().v4();
      final DateTime timeStamp = DateTime.now();

      for (var user in usersSnapshot.docs) {
        String userEmail =
            user.id; // Assuming each user's document is named by their email

        // Create a notification
        NotificationModel notification = NotificationModel(
          id: notificationId,
          title: title,
          message: message,
          timeStamp: timeStamp,
        );

        // Add the notification to each user's Notifications collection
        await _firestore
            .collection('Users')
            .doc(userEmail)
            .collection('Notifications')
            .doc(notification.id)
            .set(notification.toMap());
      }

      // Add the notification to the admin's Notifications collection as well
      await _firestore
          .collection('Users')
          .doc(adminEmail)
          .collection('Notifications')
          .doc(notificationId)
          .set({
        'id': notificationId,
        'title': title,
        'message': message,
        'timeStamp': timeStamp.toIso8601String(),
        'isRead': false,
      });
    } catch (e) {
      print('Error sending notifications: $e');
    }
  }

  // Function to get notifications for a user
  Future<List<NotificationModel>> getNotifications(String userEmail) async {
    final snapshot = await _firestore
        .collection('Users')
        .doc(userEmail)
        .collection('Notifications')
        .orderBy('timeStamp', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      return NotificationModel.fromMap(doc.data());
    }).toList();
  }
}
