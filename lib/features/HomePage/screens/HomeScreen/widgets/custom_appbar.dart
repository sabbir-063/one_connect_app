import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/features/HomePage/screens/createPost/create_post_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 1.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'ONECONNECT',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.add, color: Colors.black),
                onPressed: () {
                  // Action for creating a post
                  Get.to(() => const CreatePostPage());
                },
              ),
              IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  // Action for searching a post
                },
              ),
              // IconButton(
              //   icon: const Icon(Icons.notifications, color: Colors.black),
              //   onPressed: () {
              //     // Action for notifications
              //   },
              // ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
