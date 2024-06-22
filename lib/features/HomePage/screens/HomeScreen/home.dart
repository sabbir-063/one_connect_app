import 'package:flutter/material.dart';
import 'package:one_connect_app/features/HomePage/screens/HomeScreen/widgets/post_section.dart';

import '../../../../data/static_data/post_data/post_card_data.dart';
import '../community/donation_post_card.dart';
import 'widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostCardData postData = PostCardData();
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            /// Create Post Sectioon
            const PostSection(),

            ///Community Post Section
            Container(
              margin: const EdgeInsets.all(1),
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: postData.postCardData.length,
                itemBuilder: (context, index) {
                  final post = postData.postCardData[index];
                  return DonationPostCard(post: post);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
