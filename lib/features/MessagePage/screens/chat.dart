import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/UserModel/user_model.dart';

class ChatScreen extends StatelessWidget {
  final UserModel user;

  const ChatScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    void onSelected(BuildContext context, int item) {
      switch (item) {
        case 0:
          // Navigate to Profile View
          Get.to(() => ProfileView(user: user));
          break;
        case 1:
          // Block User Action
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Profile Picture
            const CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/profile/sabbir_profile_pic.jpg'), // Add a path to the user's profile image
              radius: 18,
            ),
            const SizedBox(width: 10),
            // User's Name
            Text('${user.firstName} ${user.lastName}'),
          ],
        ),
        actions: [
          // 3-dot Menu
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert),
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text('View Profile'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Block User'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
                // List of messages will go here
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // Send message functionality
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Example Profile View
class ProfileView extends StatelessWidget {
  final UserModel user;

  const ProfileView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lastName}'),
      ),
      body: Center(
        child: Text('Profile of ${user.firstName} ${user.lastName}'),
      ),
    );
  }
}
