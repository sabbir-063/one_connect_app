// notification_controller.dart
// import 'package:get/get.dart';

// import '../../../data/static_data/notification_data/notification_data.dart';
// import '../../../models/notificationModel/notification_model.dart';

// class NotificationController extends GetxController {
//   RxList<NotificationModel> notifications = <NotificationModel>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchNotifications();
//   }

//   void fetchNotifications() {
//     notifications.assignAll(mockNotifications); // Assign initial notifications
//   }
// }

// notification_controller.dart

import 'package:get/get.dart';

import '../../../data/static_data/notification_data/notification_data.dart';
import '../../../models/notificationModel/notification_model.dart';

class NotificationController extends GetxController {
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize notifications with mock data
    notifications.assignAll(mockNotifications);
  }

  void addNotification(NotificationModel notification) {
    notifications.add(notification);
  }

  void removeNotification(int id) {
    notifications.removeWhere((notification) => notification.id == id);
  }

  void removeAllNotifications() {
    notifications.clear();
  }
}

