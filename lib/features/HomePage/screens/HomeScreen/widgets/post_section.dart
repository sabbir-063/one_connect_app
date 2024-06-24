import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../createPost/create_post_page.dart';

class PostSection extends StatelessWidget {
  const PostSection({super.key});

  @override
  Widget build(BuildContext context) {
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
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1595152772835-219674b2a8a6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwyMDg5NzF8MHwxfGFsbHwzfHx8fHx8fHwxNjEyODUxNTU3&ixlib=rb-1.2.1&q=80&w=400'), // Replace with your image URL
                radius: 20,
              ),
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
                    child: Text(
                      "Why you need donation, Alice?",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // const Divider(height: 20, thickness: 1),
          // const Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     PostButton(
          //       icon: Icons.videocam,
          //       color: Colors.red,
          //       label: 'Live video',
          //     ),
          //     PostButton(
          //       icon: Icons.photo_library,
          //       color: Colors.green,
          //       label: 'Photo/video',
          //     ),
          //     PostButton(
          //       icon: Icons.insert_emoticon,
          //       color: Colors.amber,
          //       label: 'Feeling',
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
