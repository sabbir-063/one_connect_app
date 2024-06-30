import 'package:get/get.dart';

import '../../../data/static_data/admin_notification_data/admin_notification_data.dart';
import '../../../models/AdminNotificationModel/admin_notification_model.dart';

class AdminNotificationController extends GetxController {
  RxList<AdminNotificationModel> notifications = <AdminNotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize notifications with mock data
    notifications.assignAll(mockNotifications);
  }

  void addNotification(AdminNotificationModel notification) {
    notifications.add(notification);
  }

  void removeNotification(int id) {
    notifications.removeWhere((notification) => notification.id == id);
  }

  void removeAllNotifications() {
    notifications.clear();
  }
}
