import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../models/CreatePostModel/admin_post_model.dart';

class AdminRegularPostCard extends StatelessWidget {
  final AdminPostModel post;

  const AdminRegularPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: post.profilePicUrl.isEmpty
                    ? const NetworkImage(
                        'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=')
                    : NetworkImage(post.profilePicUrl),
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
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () {
                    // Add your donation logic here
                  },
                  icon: const Icon(Iconsax.heart),
                  label: const Text('Like'),
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
