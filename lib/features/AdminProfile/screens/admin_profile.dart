import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/features/AdminProfile/screens/admin_received_fund.dart';
import 'package:one_connect_app/features/authentication/screens/AdminLogin/admin_login.dart';
import 'package:one_connect_app/utils/constants/colors.dart';
import '../../../curr_user.dart';
// import '../../AdminAnalysis/data.controller.dart';
import '../../AdminAnalysis/donation_chats.dart';
import '../../AdminNotification/screens/admin_notification.dart';
import '../controllers/admin_profile.controller.dart';
import 'admin_create_post_donation.dart';
import 'admin_create_post_regular.dart';
import 'admin_donation_history.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminController adminController = Get.put(AdminController());
    final String adminId = OneUser.currAdminId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('OneConnect Statics'),
        centerTitle: true,
        backgroundColor: OneColors.accent,
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
      body: FutureBuilder<void>(
        future: adminController.fetchAdminData(adminId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Admin Name and Email
                        Obx(() {
                          return Text(
                            'Admin ${adminController.loggedUser.value.name}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                        const SizedBox(height: 5),
                        Obx(() {
                          return Text(
                            adminController.loggedUser.value.email,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          );
                        }),
                        const SizedBox(height: 20),

                        // Donation Stats
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Donations',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                Obx(() {
                                  return Text(
                                    '${adminController.donationGiven} Tk',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Fund Received',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                Obx(() {
                                  return Text(
                                    '${adminController.fundRaised} Tk',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Fund Remaining',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                Obx(() {
                                  return Text(
                                    '${adminController.totalRemainingCapital} Tk',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }),
                              ],
                            ),
                            //
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
                                  Get.to(() => AdminDonationHistorypage());
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
                                  Get.to(() => AdminReceivedFundpage());
                                },
                                child: const Text('Received Fund'),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        //create posts button
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Navigate to regular post
                                  Get.to(
                                      () => const AdminCreatePostRegularPage());
                                },
                                child: const Text('Regular Post'),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ), // Small space between the buttons
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Navigate to donation post
                                  Get.to(() => const AdminCreatePostPage());
                                },
                                child: const Text('Donation Post'),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 10),

                        // Additional widgets can go here if needed

                        // Charts
                        Obx(() {
                          if (adminController.isLoadingCharts.value) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return Column(
                              children: [
                                DonationGivenChart(
                                    users:
                                        adminController.dataController.users),
                                DonationReceivedChart(
                                    users:
                                        adminController.dataController.users),
                                DonationNeededVsRaisedChart(
                                    posts:
                                        adminController.dataController.posts),
                                DaywisePostCountChart(
                                    posts:
                                        adminController.dataController.posts),
                              ],
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
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
        Get.offAll(() => const AdminLoginScreen());
        break;
    }
  }
}
