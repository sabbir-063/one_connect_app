import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/features/ProfilePage/screens/widgets/user_detailsitems.dart';

import '../../AdminNotification/screens/admin_notification.dart';
import '../controllers/admin_profile.controller.dart';

class AdminProfileScreen extends StatelessWidget {
  final AdminController adminController = Get.put(AdminController());

  AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Profile'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.menu),
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Notifications'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Picture - Assuming a placeholder image
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      'assets/images/profile/shohan_shovo.jpg',
                    ), // Placeholder or actual image URL
                  ),
                  const SizedBox(height: 10),

                  // User Name and Phone - Static values
                  Text(
                    'Admin ${adminController.firstName} ${adminController.lastName}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    adminController.phone, // Static value
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Donation Stats - Static content, no need for Obx
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Donations',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '20,000 Tk',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Fund Received',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '50,000 Tk',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Buttons for Donation History and Received Organization
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to Donation History
                          },
                          child: const Text('Donation History'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ), // Small space between the buttons
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to Received Organization
                          },
                          child: const Text('Received Fund'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),

                  // Additional User Details - Static content, no need for Obx
                  const Column(
                    children: [
                      UserDetailsItem(
                        icon: Icons.email,
                        label: 'waterhorse.08@gmail.com',
                      ),
                      UserDetailsItem(
                        icon: Icons.cake,
                        label: '2001-05-01',
                      ),
                      UserDetailsItem(
                        icon: Icons.location_on,
                        label: 'Narshindi, Dhaka, Bangladesh',
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 20),

                  // Additional widgets can go here if needed
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        // Handle notifications
        Get.to(() => AdminNotificationScreen());
        break;
      case 1:
        // Handle logout
        adminController.logout();
        break;
    }
  }
}
