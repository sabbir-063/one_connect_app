import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/features/ProfilePage/controllers/logged_user.dart';
import 'package:one_connect_app/features/authentication/screens/login/login.dart';
import 'package:one_connect_app/features/notification/screens/notification.dart';
import 'package:one_connect_app/models/UserModel/user_model.dart';
import 'package:one_connect_app/features/HomePage/screens/community/donation_post_card.dart';
import 'package:one_connect_app/data/static_data/post_data/post_card_data.dart';
import 'package:one_connect_app/features/ProfilePage/screens/widgets/edit_profile.dart';
import 'package:one_connect_app/features/ProfilePage/screens/widgets/user_detailsitems.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  // Create an initial user model instance
  final UserModel initialUser = UserModel(
    firstName: 'Mohammad',
    lastName: 'Sabbir',
    email: 'sabbir.musfique01@gmail.com',
    phone: '01884952804',
    country: 'Bangladesh',
    state: 'Lakshmipur',
    city: 'Ramganj',
    birthday: '2002-06-25',
    password: '1234',
    donationGiven: 2500,
    donationReceived: 5000,
  );

  @override
  Widget build(BuildContext context) {
    // Initialize the LoggedUser controller with the initial user model
    final LoggedUser userController =
        Get.put(LoggedUser(initialUser), permanent: true);

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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Picture
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/images/profile/sabbir_profile_pic.jpg'), // Placeholder or actual image URL
                  ),
                  const SizedBox(height: 10),

                  // User Name and Phone
                  Obx(() => Text(
                        '${userController.loggedUser.value.firstName} ${userController.loggedUser.value.lastName}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(height: 5),
                  Obx(() => Text(
                        userController.loggedUser.value.phone,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                      )),
                  const SizedBox(height: 20),

                  // Donation Stats
                  Obx(() => Row(
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
                      )),
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
                          width: 10), // Small space between the buttons
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to Received Organization
                          },
                          child: const Text('Received Organization'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),

                  // Additional User Details
                  Obx(() => Column(
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
                      )),
                  const Divider(),
                  const SizedBox(height: 20),
                  const Text(
                    "My posts",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          // List of Posts
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final post = PostCardData.postCardData[index];
                return post.profileName == 'Mohammad Sabbir'
                    ? DonationPostCard(post: post)
                    : const SizedBox.shrink();
              },
              childCount: PostCardData.postCardData.length,
            ),
          ),
        ],
      ),
    );
  }

  void onSelected(BuildContext context, int item, LoggedUser userController) {
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
