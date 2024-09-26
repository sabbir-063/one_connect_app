import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/curr_user.dart';
import '../../../models/notificationModel/notification_model.dart';

class NotificationController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String userEmail = OneUser.currUserEmail;

  // Observable for notifications list and loading state
  var notifications = <NotificationModel>[].obs;
  var isLoading = false.obs; // Loading state

  @override
  void onInit() {
    super.onInit();
    getNotifications(); // Fetch notifications when the controller is initialized
  }

  // Function to get notifications for a user
  Future<void> getNotifications() async {
    try {
      isLoading.value = true; // Start loading
      final snapshot = await _firestore
          .collection('Notifications')
          .doc(userEmail)
          .collection('UserNotifications')
          .orderBy('timeStamp', descending: true)
          .get();

      notifications.value = snapshot.docs.map((doc) {
        final data = doc.data();
        return NotificationModel.fromMap(data)..id = doc.id;
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch notifications: $e");
    } finally {
      isLoading.value = false; // Stop loading when done
    }
  }
}
