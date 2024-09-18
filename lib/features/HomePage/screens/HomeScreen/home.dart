import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/features/HomePage/controllers/donation/donation_post.controller.dart';
import 'package:one_connect_app/features/HomePage/screens/HomeScreen/widgets/post_section.dart';
import '../community/admin_donation_post_card.dart';
import '../community/admin_regular_post_card.dart';
import '../community/donation_post_card.dart';
import 'widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DonationPostsUserController controller =
        Get.put(DonationPostsUserController());

    // Default selected index
    controller.selectedCategoryIndex.value = 0;

    // Define different post categories
    final List<String> postCategories = [
      'User Posts',
      'Admin Regular Posts',
      'Admin Donation Posts',
    ];

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Obx(() {
        return CustomScrollView(
          slivers: [
            // Create Post Section
            const SliverToBoxAdapter(
              child: PostSection(),
            ),

            // Horizontally scrollable buttons for post categories
            SliverToBoxAdapter(
              child: Container(
                height: 40.0,
                margin: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: postCategories.length,
                  itemBuilder: (context, index) {
                    final isSelected =
                        controller.selectedCategoryIndex.value == index;
                    return GestureDetector(
                      onTap: () {
                        // Update the selected category index when a button is tapped
                        controller.changeCategory(index);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blueAccent
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Center(
                          child: Text(
                            postCategories[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            //User Donation posts
            if (controller.filteredPosts.isEmpty)
              const SliverFillRemaining(
                child: Center(
                  child: Text(
                    'No posts available.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final post = controller.filteredPosts[index];
                    if (controller.selectedCategoryIndex.value == 0) {
                      return DonationPostCard(post: post);
                    } else if (controller.selectedCategoryIndex.value == 1) {
                      return AdminRegularPostCard(post: post);
                    } else {
                      return AdminDonationPostCard(post: post);
                    }
                  },
                  childCount: controller.filteredPosts.length,
                ),
              ),
          ],
        );
      }),
    );
  }
}
