import 'package:flutter/material.dart';

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
                    'https://via.placeholder.com/150/5733FF/FFFFFF'), // Replace with your image URL
                radius: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "What's on your mind, Mohammad?",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200]!),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200]!),
                      borderRadius: BorderRadius.circular(30.0),
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

