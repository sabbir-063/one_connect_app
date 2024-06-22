import 'package:flutter/material.dart';
import '../../../../models/CreatePostModel/post_card_model.dart';

class DonationPostCard extends StatelessWidget {
  final PostCardModel post;

  const DonationPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(15, 10, 10, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile picture and post time
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(post.profilePicUrl),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    post.profileName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  post.timeAgo,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Post message
            Text(
              post.postMessage,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 15),
            // Donation details
            Text(
              'Donation Needed: ${post.donationNeeded} Tk',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Donation Raised: ${post.donationRaised} Tk',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 15),
            // Donate, Comment, Share buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon:
                      const Icon(Icons.volunteer_activism, color: Colors.blue),
                  label: const Text('Donate',
                      style: TextStyle(color: Colors.blue)),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.comment, color: Colors.blue),
                  label: const Text('Comment',
                      style: TextStyle(color: Colors.blue)),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share, color: Colors.blue),
                  label:
                      const Text('Share', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
