import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../curr_user.dart';
import '../../../models/CreatePostModel/admin_regular_model.dart';
import '../screens/admin_post_confirmation.dart';

class AdminCreatePostRegularController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final textController = TextEditingController();
  final photos = <XFile>[].obs;
  var profileName = 'One Connect Admin'.obs;
  var profilePicUrl = ''.obs;
  var isLoading = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchUserProfile();
  // }

  // void fetchUserProfile() async {
  //   try {
  //     final userId = OneUser.currUserId;
  //     final userDoc = await _firestore.collection('Users').doc(userId).get();

  //     if (userDoc.exists) {
  //       final data = userDoc.data();
  //       if (data != null) {
  //         profileName.value = '${data['firstName']} ${data['lastName']}';
  //         profilePicUrl.value = data['profileUrl'] ?? '';
  //       }
  //     }
  //   } catch (e) {
  //     print("Error fetching user profile: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  bool validateInputs() {
    if (textController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter the reason for the donation',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    // if (donationController.text.isEmpty) {
    //   Get.snackbar('Error', 'Please enter the amount of donation needed',
    //       backgroundColor: Colors.red, colorText: Colors.white);
    //   return false;
    // }
    // if (photos.isEmpty) {
    //   Get.snackbar('Error', 'Please add at least one image',
    //       backgroundColor: Colors.red, colorText: Colors.white);
    //   return false;
    // }
    return true;
  }

  void pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      photos.addAll(images);
      update();
    }
  }

  Future<void> uploadPost() async {
    if (!validateInputs()) return;

    isLoading.value = true;
    String userId = OneUser.currAdminId;
    String formattedTime =
        DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now());
    try {
      List<String> imageUrls = await _uploadImages(userId);
      AdminRegularModel newPost = AdminRegularModel(
        userId: userId,
        profileName: profileName.value,
        profilePicUrl: profilePicUrl.value,
        timeAgo: formattedTime, // You can set an actual timestamp here
        postMessage: textController.text,
        imageUrls: imageUrls,
      );

      await _firestore.collection('AdminRegularPosts').add(newPost.toMap());
      Get.to(() => const AdminPostConfirmationPage());
    } catch (e) {
      Get.snackbar('Error', 'Failed to create post: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<String>> _uploadImages(String userId) async {
    List<String> imageUrls = [];
    for (var photo in photos) {
      String filePath = 'admin_post_images/$userId/${photo.name}';
      UploadTask uploadTask = _storage.ref(filePath).putFile(File(photo.path));
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }
    return imageUrls;
  }
}
