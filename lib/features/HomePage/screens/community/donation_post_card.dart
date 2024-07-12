import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/models/CreatePostModel/admin_post_model.dart';
import '../../controllers/donation/post_card_user.controller.dart';
import 'donate_now_button.dart';

class DonationPostCard extends StatelessWidget {
  final AdminPostModel post;

  const DonationPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final PostCardUserController controller = Get.put(PostCardUserController());
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(post.profilePicUrl),
              ),
              title: Text(post.profileName),
              subtitle: Text(post.timeAgo),
            ),
            const SizedBox(height: 10),
            Text(
              post.postMessage,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Donation Needed: ${post.donationNeeded} Tk',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Donation Raised: ${post.donationRaised} Tk',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    // Add your donation logic here
                    String phoneNumber =
                        await controller.getUserPhoneNumber(post.userId);
                    Get.to(() => const DonateNowButtonScreen(), arguments: {
                      'donationNeeded': post.donationNeeded,
                      'donationRaised': post.donationRaised,
                      'phoneNumber': phoneNumber,
                      'userId': post.userId,
                      'postId': post.id,
                    });
                  },
                  icon: const Icon(Icons.volunteer_activism),
                  label: const Text('Donate'),
                ),
                TextButton.icon(
                  onPressed: () {
                    // Add your comment logic here
                  },
                  icon: const Icon(Icons.comment),
                  label: const Text('Comment'),
                ),
                TextButton.icon(
                  onPressed: () {
                    // Add your share logic here
                  },
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                ),
              ],
            ),
          ],
        ),
      ),
    );


  }
}
