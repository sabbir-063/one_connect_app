import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../../../../curr_user.dart';
import '../../../../models/CreatePostModel/admin_post_model.dart';
import '../../screens/createPost/post_confirmation.dart';
import 'package:intl/intl.dart';

class CreatePostController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final textController = TextEditingController();
  final donationController = TextEditingController();
  final photos = <XFile>[].obs;
  var profileName = ''.obs;
  var profilePicUrl = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    try {
      final userId = OneUser.currUserId;
      final userDoc = await _firestore.collection('Users').doc(userId).get();

      if (userDoc.exists) {
        final data = userDoc.data();
        if (data != null) {
          profileName.value = '${data['firstName']} ${data['lastName']}';
          profilePicUrl.value = data['profileUrl'] ?? '';
        }
      }
    } catch (e) {
      print("Error fetching user profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  bool validateInputs() {
    if (textController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter the reason for the donation',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    if (donationController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter the amount of donation needed',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    if (photos.isEmpty) {
      Get.snackbar('Error', 'Please add at least one image',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
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
    String userId = OneUser.currUserId;
    String formattedTime =
        DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now());
    try {
      List<String> imageUrls = await _uploadImages(userId);
      AdminPostModel newPost = AdminPostModel(
        userId: userId,
        profileName: profileName.value,
        profilePicUrl: profilePicUrl.value,
        timeAgo: formattedTime, // You can set an actual timestamp here
        postMessage: textController.text,
        donationNeeded: int.parse(donationController.text),
        imageUrls: imageUrls,
      );

      await _firestore.collection('Posts').add(newPost.toMap());
      Get.to(() => const PostConfirmationPage());
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
      String filePath = 'post_images/$userId/${photo.name}';
      UploadTask uploadTask = _storage.ref(filePath).putFile(File(photo.path));
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }
    return imageUrls;
  }
}






















// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// import '../../../../curr_user.dart';
// import '../../../../models/CreatePostModel/admin_post_model.dart';
// import '../../screens/createPost/post_confirmation.dart';

// class CreatePostController extends GetxController {
//   final textController = TextEditingController();
//   final donationController = TextEditingController();
//   final photos = <XFile>[].obs;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   var profileName = ''.obs;
//   var profilePicUrl = ''.obs;


//   @override
//   void onInit() {
//     super.onInit();
//     fetchUserProfile();
//   }


//   Future<void> createPost(
//       String userId, String profileName, String profilePicUrl) async {
//     if (!_validateInputs()) {
//       return;
//     }

//     try {
//       List<String> imageUrls = await _uploadImages(userId);
//       AdminPostModel newPost = AdminPostModel(
//         userId: userId,
//         profileName: profileName,
//         profilePicUrl: profilePicUrl,
//         timeAgo: 'Just now', // You can set an actual timestamp here
//         postMessage: textController.text,
//         donationNeeded: int.parse(donationController.text),
//         imageUrls: imageUrls,
//       );

//       await _firestore.collection('Posts').add(newPost.toMap());
//       Get.to(() => const PostConfirmationPage());
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to create post. Please try again.',
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }

//   bool _validateInputs() {
//     if (textController.text.isEmpty) {
//       _showErrorSnackbar('Please enter a message.');
//       return false;
//     }
//     if (donationController.text.isEmpty) {
//       _showErrorSnackbar('Please enter the donation needed.');
//       return false;
//     }
//     if (photos.isEmpty) {
//       _showErrorSnackbar('Please select at least one image.');
//       return false;
//     }
//     return true;
//   }

//   Future<List<String>> _uploadImages(String userId) async {
//     List<String> imageUrls = [];
//     for (var photo in photos) {
//       String filePath = 'post_images/$userId/${photo.name}';
//       UploadTask uploadTask = _storage.ref(filePath).putFile(File(photo.path));
//       TaskSnapshot snapshot = await uploadTask;
//       String downloadUrl = await snapshot.ref.getDownloadURL();
//       imageUrls.add(downloadUrl);
//     }
//     return imageUrls;
//   }

//   void fetchUserProfile() async {
//     try {
//       final userId = OneUser.currUserId;
//       final userDoc = await _firestore.collection('users').doc(userId).get();

//       if (userDoc.exists) {
//         final data = userDoc.data();
//         if (data != null) {
//           profileName.value = '${data['firstName']} ${data['lastName']}';
//           profilePicUrl.value = data['profilePicUrl'] ?? '';
//         }
//       }
//     } catch (e) {
//       print("Error fetching user profile: $e");
//     }
//   }

//   void _showErrorSnackbar(String message) {
//     Get.snackbar('Error', message,
//         backgroundColor: Colors.red, colorText: Colors.white);
//   }
// }
