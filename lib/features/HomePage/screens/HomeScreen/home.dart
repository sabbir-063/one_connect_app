import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/features/HomePage/controllers/donation/donation_post.controller.dart';
import 'package:one_connect_app/features/HomePage/screens/HomeScreen/widgets/post_section.dart';
import '../community/donation_post_card.dart';
import 'widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DonationPostsUserController controller =
        Get.put(DonationPostsUserController());

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Obx(() {
        return CustomScrollView(
          slivers: [
            // Create Post Section
            const SliverToBoxAdapter(
              child: PostSection(),
            ),
            // Community Post Section
            // if (controller.isLoading.value)
            //   const SliverFillRemaining(
            //     child: Center(child: CircularProgressIndicator()),
            //   )
            if (controller.posts.isEmpty)
              const SliverFillRemaining(
                child: Center(
                  child: Text(
                    'No posts available for donation',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final post = controller.posts[index];
                    return DonationPostCard(post: post);
                  },
                  childCount: controller.posts.length,
                ),
              ),
          ],
        );
      }),
    );
  }
}
