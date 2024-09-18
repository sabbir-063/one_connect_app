import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/utils/constants/colors.dart';
import 'package:photo_view/photo_view.dart';

import '../../../utils/helpers/helper_functions.dart';
import '../controllers/admin_home.controller.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminHomeController controller = Get.put(AdminHomeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Posts'),
        centerTitle: true,
        backgroundColor: OneColors.accent,
      ),
      body: Obx(() {
        if (controller.posts.isEmpty) {
          return const Center(
            child: Text('No pending posts for approval.'),
          );
        }
        return ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            final post = controller.posts[index];
            return Card(
              margin: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<String>(
                      future: controller.getUserFullName(
                          post.userId), // Future to get the full name
                      builder: (context, nameSnapshot) {
                        return FutureBuilder<bool>(
                          future: OneHelperFunctions.isProfilePicEmpty(post
                              .userId), // Future to check if profilePic is empty
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
                                future: OneHelperFunctions.getProfilePicUrl(post
                                    .userId), // Future to get profile picture URL
                                builder: (context, profilePicSnapshot) {
                                  if (profilePicSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const ListTile(
                                      title: Text('Loading...'),
                                      subtitle:
                                          Text('Fetching profile picture...'),
                                      leading: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/loading/loading_spinner.gif'), // Loading placeholder
                                      ),
                                    );
                                  } else if (profilePicSnapshot.hasError) {
                                    return const ListTile(
                                      title: Text('Error'),
                                      subtitle: Text(
                                          'Failed to fetch profile picture'),
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=', // Default image in case of error
                                        ),
                                      ),
                                    );
                                  } else {
                                    final bool isEmpty =
                                        isEmptySnapshot.data ?? true;
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
                                      title: Text(
                                          nameSnapshot.data ?? 'Unknown User'),
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
                    Text(
                      post.postMessage,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Donation Needed: ${post.donationNeeded} Taka',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => controller.acceptPost(post.id),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 60,
                              vertical: 10,
                            ),
                          ),
                          child: const Text('Accept'),
                        ),
                        ElevatedButton(
                          onPressed: () => controller.rejectPost(post.id),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 60,
                              vertical: 10,
                            ),
                          ),
                          child: const Text('Reject'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
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
