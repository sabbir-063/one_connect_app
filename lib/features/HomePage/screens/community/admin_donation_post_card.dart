import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/curr_user.dart';
import 'package:one_connect_app/models/CreatePostModel/admin_post_model.dart';
import 'package:photo_view/photo_view.dart';
import '../../controllers/donation/post_card_user.controller.dart';
import 'admin_donate_now_button.dart';

class AdminDonationPostCard extends StatelessWidget {
  final AdminPostModel post;

  const AdminDonationPostCard({super.key, required this.post});

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

            //images
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
                  onPressed: () async {
                    // Add your donation logic here
                    if ('0' == OneUser.currAdminId) {
                      String phoneNumber =
                          await controller.getCentralPhoneNumber(post.userId);
                      Get.to(() => const AdminDonateNowButtonScreen(),
                          arguments: {
                            'donationNeeded': post.donationNeeded,
                            'donationRaised': post.donationRaised,
                            'phoneNumber': phoneNumber,
                            'userId': post.userId,
                            'postId': post.id,
                          });
                    } else if (OneUser.currUserId != '0') {
                      String phoneNumber =
                          await controller.getCentralPhoneNumber(post.userId);
                      Get.to(() => const AdminDonateNowButtonScreen(),
                          arguments: {
                            'donationNeeded': post.donationNeeded,
                            'donationRaised': post.donationRaised,
                            'phoneNumber': phoneNumber,
                            'userId': post.userId,
                            'postId': post.id,
                          });
                    } else {
                      Get.snackbar('Error', "You can't donate yourself");
                    }
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
