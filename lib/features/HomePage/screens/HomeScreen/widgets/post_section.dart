import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/createPost/post_image_name.controller.dart';
import '../../createPost/create_post_page.dart';

class PostSection extends StatelessWidget {
  const PostSection({super.key});

  @override
  Widget build(BuildContext context) {
    final PostImageNameController controller =
        Get.put(PostImageNameController());

    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Obx(() {
                return CircleAvatar(
                  backgroundImage: controller.profilePicUrl.value.isNotEmpty
                      ? NetworkImage(controller.profilePicUrl.value)
                      : const AssetImage(
                              'assets/images/profile/sabbir_profile_pic.jpg')
                          as ImageProvider,
                  radius: 20,
                );
              }),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const CreatePostPage());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    child: Obx(() {
                      return Text(
                        "Why you need donation, ${controller.firstname.value}?",
                        style: TextStyle(color: Colors.grey[600]),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),

          //
        ],
      ),
    );
  }
}
