import 'package:get/get.dart';
import 'package:one_connect_app/models/UserModel/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../navigation_bar.dart';

class LoggedUser extends GetxController {
  // Reactive user model
  Rx<UserModel> loggedUser = UserModel(
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    country: '',
    state: '',
    city: '',
    birthday: '',
    password: '',
  ).obs;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to fetch user data from Firestore
  Future<void> fetchUserData(String userId) async {
    try {
      // Fetch user document from Firestore
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('Users').doc(userId).get();

      // Convert Firestore data to UserModel
      if (userDoc.exists) {
        loggedUser.value = UserModel.fromMap(userDoc.data()!);
      } else {
        // Handle if user document does not exist
        Get.snackbar('Error', 'User data not found.');
      }
    } catch (e) {
      // Handle any errors
      Get.snackbar('Error', 'Failed to fetch user data: $e');
    }
  }

  // Method to update the user profile
  void updateProfile({
    String? firstName,
    String? lastName,
    String? country,
    String? state,
    String? city,
    String? birthday,
    String? password,
  }) {
    // Update fields if provided
    loggedUser.update((user) {
      if (user != null) {
        user.firstName = firstName ?? user.firstName;
        user.lastName = lastName ?? user.lastName;
        user.country = country ?? user.country;
        user.state = state ?? user.state;
        user.city = city ?? user.city;
        user.birthday = birthday ?? user.birthday;

        // Update password if provided (and valid)
        if (password != null && password.isNotEmpty) {
          user.password = password;
        }
      }
    });
  }

  // Method to navigate to the profile page (index 4) in the navigation bar
  void navigateToProfile() {
    Get.find<NavigationController>().selectedIndx.value = 4;
  }
}
