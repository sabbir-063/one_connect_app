import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:one_connect_app/utils/constants/colors.dart';
import '../controllers/notification.controller.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final NotificationController controller = Get.put(NotificationController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        backgroundColor: OneColors.accent,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(), // Show loading indicator
          );
        } else if (controller.notifications.isEmpty) {
          return const Center(child: Text('No notifications found.'));
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0), // Add padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(controller.notifications.length, (index) {
                final notification = controller.notifications[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      notification.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    subtitle: Text(notification.message),
                    trailing: Text(DateFormat('yyyy-MM-dd - kk:mm')
                        .format(notification.timeStamp)),
                    // trailing: notification.isRead
                    //     ? const Icon(Icons.check, color: Colors.green)
                    //     : const Icon(Icons.circle, color: Colors.red),
                  ),
                );
              }),
            ),
          );
        }
      }),
    );
  }
}
