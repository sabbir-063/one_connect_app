import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/features/AdminProfile/screens/admin_received_fund.dart';
import 'package:one_connect_app/features/authentication/screens/AdminLogin/admin_login.dart';
import 'package:one_connect_app/utils/constants/colors.dart';
import '../../../curr_user.dart';
// import '../../AdminAnalysis/data.controller.dart';
import '../../AdminNotification/screens/admin_notification.dart';
import '../../HomePage/screens/community/admin_donation_post_card.dart';
import '../../HomePage/screens/community/admin_regular_post_card.dart';
import '../controllers/admin_profile.controller.dart';
import 'admin_create_post_donation.dart';
import 'admin_create_post_regular.dart';
import 'admin_donation_history.dart';
import 'admin_graph_statics.dart';

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
                // Wrapping your regular widgets inside SliverToBoxAdapter
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          return Text(
                            'Admin : ${adminController.loggedUser.value.name}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }),
                        const SizedBox(height: 5),
                        Obx(() {
                          return Text(
                            'Email : ${adminController.loggedUser.value.email}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          );
                        }),
                        const SizedBox(height: 20),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Column(
                        //       children: [
                        //         const Text(
                        //           'Donations',
                        //           style: TextStyle(
                        //             fontSize: 18,
                        //             color: Colors.grey,
                        //           ),
                        //         ),
                        // Obx(() {
                        //   return Text(
                        //     '${adminController.donationGiven} Tk',
                        //     style: const TextStyle(
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   );
                        // }),
                        //       ],
                        //     ),
                        //     Column(
                        //       children: [
                        //         const Text(
                        //           'Fund Received',
                        //           style: TextStyle(
                        //             fontSize: 18,
                        //             color: Colors.grey,
                        //           ),
                        //         ),
                        //         Obx(() {
                        //           return Text(
                        //             '${adminController.fundRaised} Tk',
                        //             style: const TextStyle(
                        //               fontSize: 20,
                        //               fontWeight: FontWeight.bold,
                        //             ),
                        //           );
                        //         }),
                        //       ],
                        //     ),
                        //     Column(
                        //       children: [
                        //         const Text(
                        //           'Fund Remaining',
                        //           style: TextStyle(
                        //             fontSize: 18,
                        //             color: Colors.grey,
                        //           ),
                        //         ),
                        //         Obx(() {
                        //           return Text(
                        //             '${adminController.totalRemainingCapital} Tk',
                        //             style: const TextStyle(
                        //               fontSize: 20,
                        //               fontWeight: FontWeight.bold,
                        //             ),
                        //           );
                        //         }),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        const Divider(
                          thickness: 5,
                        ),
                        const SizedBox(height: 10),
                        Obx(() {
                          return Text(
                            'Donation Given : ${adminController.donationGiven} Tk',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                        const SizedBox(height: 15),
                        Obx(() {
                          return Text(
                            'Fund Received : ${adminController.fundRaised} Tk',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                        const SizedBox(height: 15),
                        Obx(() {
                          return Text(
                            'Fund Remaining : ${adminController.totalRemainingCapital} Tk',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                        const SizedBox(height: 15),
                        Obx(() {
                          return Text(
                              'Special Fund Raised : ${adminController.specialFundRaised} Tk',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold));
                        }),
                        const SizedBox(height: 10),
                        const Divider(
                          thickness: 5,
                        ),
                        const SizedBox(height: 20),

                        /////////buttons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => AdminDonationHistorypage());
                                },
                                child: const Text('Donation History'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => AdminReceivedFundpage());
                                },
                                child: const Text('Received Fund'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(
                                      () => const AdminCreatePostRegularPage());
                                },
                                child: const Text('Create Regular Post'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => const AdminCreatePostPage());
                                },
                                child: const Text('Create Donation Post'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => const AdminGraphStaticsPage());
                                },
                                child:
                                    const Text('OneConnect Analysis (Graph)'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 10),
                        const Center(
                          child: Text(
                            "Admin posts",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),

                        const SizedBox(height: 20),
                        // Loading or Donation Posts
                        Obx(() {
                          if (adminController.isLoadingDonationPosts.value) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (adminController.filteredPostsDonation.isEmpty) {
                            return const Text('No donation posts available.');
                          }
                          return Column(
                            children: adminController.filteredPostsDonation
                                .map(
                                    (post) => AdminDonationPostCard(post: post))
                                .toList(),
                          );
                        }),

                        const SizedBox(height: 10),

                        // Loading or Regular Posts
                        Obx(() {
                          if (adminController.isLoadingRegularPosts.value) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (adminController.filteredPostsRegular.isEmpty) {
                            return const Text('No regular posts available.');
                          }
                          return Column(
                            children: adminController.filteredPostsRegular
                                .map((post) => AdminRegularPostCard(post: post))
                                .toList(),
                          );
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
        Get.to(() => AdminNotificationScreen());
        break;
      case 1:
        OneUser.currAdminId = '0';
        Get.offAll(() => const AdminLoginScreen());
        break;
    }
  }
}
