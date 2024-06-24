import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/post.controller.dart';
import 'widgets/posts_list_widget.dart';

class AdminHomeScreen extends StatelessWidget {
  AdminHomeScreen({super.key});

  final PostController postController = Get.put(PostController());
  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('    Posts List for Approvement'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          if (postController.posts.isEmpty) {
            return const Center(
              child: Text('No posts available for approval.'),
            );
          }
          return PostsList(posts: postController.posts);
        }),
      ),
    );
  }
}
