import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/notificationModel/notification_model.dart';
import '../controllers/notification.controller.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationController notificationController =
      Get.put(NotificationController());

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: notificationController.notifications.length,
          itemBuilder: (context, index) {
            NotificationModel notification =
                notificationController.notifications[index];
            return _buildNotificationCard(
                context, notification); // Pass context here
          },
        ),
      ),
    );
  }

  Widget _buildNotificationCard(
      BuildContext context, NotificationModel notification) {
    String timeAgo = DateFormat.yMMMd().add_jm().format(notification.timestamp);

    return Dismissible(
      key: Key(notification.id.toString()),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        notificationController.removeNotification(notification.id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification dismissed')),
        );
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        elevation: 2,
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.transparent,
            child: Image.asset(
              'assets/logos/one-connect.png',
              width: 50,
              height: 50,
            ),
          ),
          title: Text(notification.header),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(notification.subheader),
              const SizedBox(height: 5),
              Text(
                timeAgo,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
