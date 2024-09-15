import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/utils/constants/colors.dart';
import '../controllers/donation_posts.controller.dart';
import 'post_card_widget.dart';

class AdminPostScreen extends StatelessWidget {
  const AdminPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DonationPostsController controller =
        Get.put(DonationPostsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Posts'),
        centerTitle: true,
        backgroundColor: OneColors.accent,
      ),
      body: Obx(() {
        if (controller.posts.isEmpty) {
          return const Center(
            child: Text('No donation posts available.'),
          );
        }
        return ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            final post = controller.posts[index];
            return PostCardWidget(post: post);
          },
        );
      }),
    );
  }
}
