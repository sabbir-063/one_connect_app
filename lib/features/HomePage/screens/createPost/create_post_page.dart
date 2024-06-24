import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/createPost/create_post.controller.dart';
import 'post_confirmation.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreatePostController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          Container(
            height: 50,
            margin: const EdgeInsets.only(right: 10),
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => const PostConfirmationPage());
              },
              child: const Text('POST'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 200,
                child: TextField(
                  controller: controller.textController,
                  maxLength: 3000,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: "Why do you need a donation?",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.only(
                      top: 10.0, // Adjust this value as needed
                      left: 15.0,
                      right: 15.0,
                    ),
                  ),
                  onChanged: (_) => controller.update(),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  const Text(
                    "Donation needed : ",
                    style: TextStyle(fontSize: 25),
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller.donationController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "",
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      onChanged: (_) => controller.update(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Taka',
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(width: 20),
                ],
              ),

              const SizedBox(height: 10),

              Obx(
                () => Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    ...controller.photos.map((photo) => Image.file(
                          File(photo.path),
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        )),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final List<XFile>? images =
                              await picker.pickMultiImage();
                          if (images != null) {
                            controller.photos.addAll(images);
                            controller.update();
                          }
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Iconsax.gallery_export4,
                              size: 30.0, // you can adjust the size if needed
                            ),
                            SizedBox(
                                width: 8.0), // spacing between icon and text
                            Text(
                              "Photo",
                              style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 33, 213, 126),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                  height: 100), // Extra space at the bottom for scrolling
            ],
          ),
        ),
      ),
    );
  }
}
