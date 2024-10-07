// import 'dart:math';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:one_connect_app/curr_user.dart';

import '../../../models/UserModel/user_model.dart';
import '../../../navigation_bar.dart';

class EditProfileController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<UserModel> loggedUser = UserModel(
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    country: '',
    state: '',
    city: '',
    birthday: '',
    profileUrl: '',
    password: '',
  ).obs;

  // final currentPassword = ''.obs;
  // final newPassword = ''.obs;

  Future<void> fetchUserData(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(userId).get();
      if (userDoc.exists) {
        loggedUser.value =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> updateUserProfile() async {
    try {
      Map<String, dynamic> updateData = {
        'firstName': loggedUser.value.firstName,
        'lastName': loggedUser.value.lastName,
        'birthday': loggedUser.value.birthday,
        'country': loggedUser.value.country,
        'state': loggedUser.value.state,
        'city': loggedUser.value.city,
        'phone': loggedUser.value.phone,
      };

      // if (currentPassword.isNotEmpty && newPassword.isNotEmpty) {
      //   User? user = _auth.currentUser;
      //   if (user != null) {
      //     final cred = EmailAuthProvider.credential(
      //       email: user.email!,
      //       password: currentPassword.value,
      //     );

      //     await user.reauthenticateWithCredential(cred);
      //     await user.updatePassword(newPassword.value);
      //   }
      // }

      await _firestore
          .collection('Users')
          .doc(OneUser.currUserId)
          .update(updateData);

      Get.offAll(() => const NavigationBarMenu());
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e');
    }
  }
}
