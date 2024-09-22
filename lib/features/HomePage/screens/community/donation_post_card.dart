import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/curr_user.dart';
import 'package:one_connect_app/models/CreatePostModel/admin_post_model.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/donation/post_card_user.controller.dart';
import 'donate_now_button.dart';
import 'transaction_history_page.dart';

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
            FutureBuilder<String>(
              future: controller
                  .getUserFullName(post.userId), // Future to get the full name
              builder: (context, nameSnapshot) {
                return FutureBuilder<bool>(
                  future: OneHelperFunctions.isProfilePicEmpty(
                      post.userId), // Future to check if profilePic is empty
                  builder: (context, isEmptySnapshot) {
                    if (nameSnapshot.connectionState ==
                            ConnectionState.waiting ||
                        isEmptySnapshot.connectionState ==
                            ConnectionState.waiting) {
                      return const ListTile(
                        title: Text('Loading...'),
                        subtitle: Text('Fetching user details...'),
                      );
                    } else if (nameSnapshot.hasError ||
                        isEmptySnapshot.hasError) {
                      return const ListTile(
                        title: Text('Error'),
                        subtitle: Text('Failed to fetch user details'),
                      );
                    } else {
                      // Add another FutureBuilder for fetching the profile picture URL
                      return FutureBuilder<String>(
                        future: OneHelperFunctions.getProfilePicUrl(
                            post.userId), // Future to get profile picture URL
                        builder: (context, profilePicSnapshot) {
                          if (profilePicSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const ListTile(
                              title: Text('Loading...'),
                              subtitle: Text('Fetching profile picture...'),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/loading/loading_spinner.gif'), // Loading placeholder
                              ),
                            );
                          } else if (profilePicSnapshot.hasError) {
                            return const ListTile(
                              title: Text('Error'),
                              subtitle: Text('Failed to fetch profile picture'),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=', // Default image in case of error
                                ),
                              ),
                            );
                          } else {
                            final bool isEmpty = isEmptySnapshot.data ?? true;
                            final String profilePicUrl =
                                profilePicSnapshot.data ?? '';
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: isEmpty
                                    ? const NetworkImage(
                                        'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=') // Default image
                                    : NetworkImage(
                                        profilePicUrl), // Profile picture URL
                              ),
                              title: Text(nameSnapshot.data ?? 'Unknown User'),
                              subtitle: Text(post.timeAgo),
                            );
                          }
                        },
                      );
                    }
                  },
                );
              },
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
            // const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Donation needed: ${post.donationNeeded} Tk',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            // const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Get.to(() => TransactionHistoryPage(postID: post.id));
              },
              child: Text(
                'Donation Raised: ${post.donationRaised} Tk',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    if (post.userId != OneUser.currUserId) {
                      String phoneNumber =
                          await controller.getUserPhoneNumber(post.userId);
                      Get.to(() => const DonateNowButtonScreen(), arguments: {
                        'donationNeeded': post.donationNeeded,
                        'donationRaised': post.donationRaised,
                        'phoneNumber': phoneNumber,
                        'userId': post.userId,
                        'postId': post.id,
                      });
                    } else {
                      Get.snackbar('Error', "You can't donate to yourself");
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
}
