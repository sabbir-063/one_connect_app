import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import '../../../curr_user.dart';
import '../../../models/CreatePostModel/admin_post_model.dart';
import '../../../models/UserModel/user_model.dart';
import '../../HomePage/controllers/createPost/post_image_name.controller.dart';

class ProfileController extends GetxController {
  final Rx<UserModel> loggedUser = UserModel(
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    country: '',
    state: '',
    city: '',
    birthday: '',
    password: '',
    profileUrl: '',
  ).obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  var posts = <AdminPostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    // isLoading(true);
    try {
      final snapshot = await _firestore
          .collection('Posts')
          .where('postAccepted', isEqualTo: true)
          .get();

      final filteredPosts = snapshot.docs.where((doc) {
        final post = AdminPostModel.fromMap(doc.data());
        return post.userId == OneUser.currUserId;
      }).toList();

      posts.value = filteredPosts.map((doc) {
        final data = doc.data();
        return AdminPostModel.fromMap(data)..id = doc.id;
      }).toList();
    } catch (e) {
      // Handle error
      // print("Error fetching posts: $e");
    }
  }

  // ignore: unused_element
  Future<void> fetchUserData(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(userId).get();
      if (userDoc.exists) {
        loggedUser.value =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      // print("Error fetching user data: $e");
    }
  }

  // ignore: unused_element
  Future<void> updateProfilePicture(String userId, XFile imageFile) async {
    try {
      // Define the file path
      String filePath = 'profile_pictures/$userId/picture.png';

      // Delete the previous profile picture if it exists
      if (loggedUser.value.profileUrl.isNotEmpty &&
          OneUser.isGoogleAccount == false) {
        try {
          await _storage.refFromURL(loggedUser.value.profileUrl).delete();
        } catch (e) {
          // print("Error deleting previous profile picture: $e");
        }
      }

      // Upload the new image to Firebase Storage
      await _storage.ref(filePath).putFile(File(imageFile.path));

      // Get the download URL
      String downloadUrl = await _storage.ref(filePath).getDownloadURL();

      // Update Firestore with the new profile URL
      await _firestore.collection('Users').doc(userId).update({
        'profileUrl': downloadUrl,
      });

      // Update the local user model
      loggedUser.update((user) {
        user?.profileUrl = downloadUrl;
      });
      final controller2 = Get.find<PostImageNameController>();
      controller2.updateUserProfile();
    } catch (e) {
      // print("Error updating profile picture: $e");
    }
  }

  Future<String> getUserFullName(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(userId).get();
      if (userDoc.exists) {
        UserModel user =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        String nAME = '${user.firstName} ${user.lastName}';
        return nAME;
      } else {
        // Get.snackbar('Error', 'User not found');
        return '';
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user details: $e');
      return '';
    }
  }
}
