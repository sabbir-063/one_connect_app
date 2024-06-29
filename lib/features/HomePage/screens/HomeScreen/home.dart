import 'package:flutter/material.dart';
import 'package:one_connect_app/features/HomePage/screens/HomeScreen/widgets/post_section.dart';

import '../../../../data/static_data/post_data/post_card_data.dart';
import '../community/donation_post_card.dart';
import 'widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: CustomScrollView(
        slivers: [
          // Create Post Section
          const SliverToBoxAdapter(
            child: PostSection(),
          ),
          // Community Post Section
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final post = PostCardData.postCardData[index];
                return DonationPostCard(post: post);
              },
              childCount: PostCardData.postCardData.length,
            ),
          ),
        ],
      ),
    );
  }
}
