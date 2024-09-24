import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/notificationModel/notification_model.dart';
import '../controllers/notification.controller.dart';

class NotificationsPage extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());
  final String userEmail;

  NotificationsPage({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: controller.getNotifications(userEmail),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No notifications found.'));
          } else {
            final notifications = snapshot.data!;
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];

                return ListTile(
                  title: Text(notification.title),
                  subtitle: Text(notification.message),
                  trailing: notification.isRead
                      ? const Icon(Icons.check, color: Colors.green)
                      : const Icon(Icons.circle, color: Colors.red),
                );
              },
            );
          }
        },
      ),
    );
  }
}
