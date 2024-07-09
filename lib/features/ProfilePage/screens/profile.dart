import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/features/ProfilePage/controllers/logged_user.dart';
import 'package:one_connect_app/features/ProfilePage/screens/DonationsHistory/donation_History.dart';
import 'package:one_connect_app/features/authentication/screens/login/login.dart';
import 'package:one_connect_app/features/notification/screens/notification.dart';
import 'package:one_connect_app/features/HomePage/screens/community/donation_post_card.dart';
import 'package:one_connect_app/data/static_data/post_data/post_card_data.dart';
import 'package:one_connect_app/features/ProfilePage/screens/widgets/edit_profile.dart';
import 'package:one_connect_app/features/ProfilePage/screens/widgets/user_detailsitems.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the LoggedUser controller
    final LoggedUser userController = Get.put(LoggedUser());

    // Fetch user data when screen initializes
    Future.microtask(() async {
      await userController
          .fetchUserData('userId'); // Replace 'userId' with actual user ID
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.menu),
            onSelected: (item) => onSelected(context, item, userController),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Profile Edit'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Notifications'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: Obx(() {
        if (userController.loggedUser.value.firstName.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Picture (Add your logic for profile picture)
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                            'assets/images/profile/sabbir_profile_pic.jpg'), // Placeholder or actual image URL
                      ),
                      const SizedBox(height: 10),

                      // User Name and Phone
                      Text(
                        '${userController.loggedUser.value.firstName} ${userController.loggedUser.value.lastName}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        userController.loggedUser.value.phone,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      const SizedBox(height: 20),

                      // Donation Stats
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text('Donations',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey)),
                              Text(
                                  '${userController.loggedUser.value.donationGiven.toString()} Tk',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            children: [
                              const Text('Received',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey)),
                              Text(
                                  '${userController.loggedUser.value.donationReceived.toString()} Tk',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
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
                                Get.to(() => DonationHistoryPage(
                                    email:
                                        userController.loggedUser.value.email));
                              },
                              child: const Text('Donation History'),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 10),

                      // Additional User Details
                      Column(
                        children: [
                          UserDetailsItem(
                            icon: Icons.email,
                            label: userController.loggedUser.value.email,
                          ),
                          UserDetailsItem(
                            icon: Icons.cake,
                            label: userController.loggedUser.value.birthday,
                          ),
                          UserDetailsItem(
                            icon: Icons.location_on,
                            label:
                                '${userController.loggedUser.value.city}, ${userController.loggedUser.value.state}, ${userController.loggedUser.value.country}',
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(height: 20),
                      const Text(
                        "My posts",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              // List of Posts (Modify as per your logic)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final post = PostCardData.postCardData[index];
                    return post.profileName ==
                            '${userController.loggedUser.value.firstName} ${userController.loggedUser.value.lastName}'
                        ? DonationPostCard(post: post)
                        : const SizedBox.shrink();
                  },
                  childCount: PostCardData.postCardData.length,
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  void onSelected(
      BuildContext context, int item, LoggedUser userController) async {
    switch (item) {
      case 0:
        // Navigate to Edit Profile
        Get.to(() => EditProfileScreen());
        break;
      case 1:
        // Handle notifications
        Get.to(() => NotificationScreen());
        break;
      case 2:
        // Handle logout
        Get.offAll(() => const LoginScreen());
        break;
    }
  }
}
