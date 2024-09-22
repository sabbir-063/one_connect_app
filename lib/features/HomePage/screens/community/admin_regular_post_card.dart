import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:photo_view/photo_view.dart';

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
                        'https://i.ibb.co.com/kXy1Bnb/One-Connect.png')
                    : NetworkImage(post.profilePicUrl),
              ),
              title: Text(post.profileName),
              subtitle: Text(post.timeAgo),
            ),
            const SizedBox(height: 10),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
              child: GestureDetector(
                onLongPress: () {
                  Clipboard.setData(ClipboardData(
                      text: post.postMessage)); // Copy text to clipboard
                  HapticFeedback.vibrate();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Post message copied!'),
                    ),
                  );
                },
                child: Text(
                  post.postMessage,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 10),

            //show images
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: post.imageUrls.map((url) {
                return GestureDetector(
                  onTap: () => showEnlargedImage(context, url),
                  child: Image.network(
                    url,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
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

  void showEnlargedImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Center(
                child: PhotoView(
                  imageProvider: NetworkImage(imageUrl),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
