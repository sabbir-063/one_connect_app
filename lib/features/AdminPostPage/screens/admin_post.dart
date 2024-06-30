import 'package:flutter/material.dart';

import '../../../data/static_data/post_data/post_card_data.dart';
import '../../HomePage/screens/community/donation_post_card.dart';

class AdminPostScreen extends StatelessWidget {
  const AdminPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Posts'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
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
