import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/models/UserModel/user_model.dart';
import 'package:one_connect_app/navigation_bar.dart';

class LoggedUser extends GetxController {
  // Reactive user model
  Rx<UserModel> loggedUser;

  // New Password field (optional)
  // String newPassword = '';

  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Constructor to initialize with a UserModel instance
  LoggedUser(UserModel user)
      : loggedUser = user.obs; // Initialize the reactive user

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
