import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/models/UserModel/user_model.dart';

import '../../../navigation_bar.dart';
import '../../ProfilePage/controllers/logged_user.dart';

class EditProfileController extends GetxController {
  // LoggedUser controller instance
  final LoggedUser loggedUserController = Get.find<LoggedUser>();

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Controllers for form fields
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController passwordController;
  late TextEditingController currentPasswordController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController countryController;
  late TextEditingController stateController;
  late TextEditingController cityController;
  late TextEditingController birthdayController;

  @override
  void onInit() {
    super.onInit();
    // Initialize controllers with current user data from loggedUser
    final UserModel user = loggedUserController.loggedUser.value;

    firstNameController = TextEditingController(text: user.firstName);
    lastNameController = TextEditingController(text: user.lastName);
    passwordController = TextEditingController();
    currentPasswordController = TextEditingController();
    emailController = TextEditingController(text: user.email);
    phoneController = TextEditingController(text: user.phone);
    countryController = TextEditingController(text: user.country);
    stateController = TextEditingController(text: user.state);
    cityController = TextEditingController(text: user.city);
    birthdayController = TextEditingController(text: user.birthday);
  }

  void updateProfile() {
    if (formKey.currentState!.validate()) {
      // Check if the current password is correct
      if (currentPasswordController.text !=
          loggedUserController.loggedUser.value.password) {
        Get.snackbar('Error', 'Current password is incorrect.',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      // Call updateProfile method from LoggedUser controller
      loggedUserController.updateProfile(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        country: countryController.text,
        state: stateController.text,
        city: cityController.text,
        birthday: birthdayController.text,
        password:
            passwordController.text.isNotEmpty ? passwordController.text : null,
      );

      // Navigate back to the Profile tab
      Get.find<NavigationController>().selectedIndx.value = 4;
      Get.offAll(() => const NavigationBarMenu());

      // Show a success message
      Get.snackbar('Success', 'Profile updated successfully.',
          snackPosition: SnackPosition.TOP);
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    currentPasswordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    birthdayController.dispose();
    super.onClose();
  }
}
