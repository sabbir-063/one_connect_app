import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/UserModel/user_model.dart';
import '../../../../navigation_bar.dart';
import '../../screens/signup/widgets/email_verification.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final birthdayController = TextEditingController();
  final passwordController = TextEditingController();

  String country = '';
  String state = '';
  String city = '';
  bool agreeToTerms = true;

  void setAgreeToTerms(bool value) {
    agreeToTerms = value;
    update();
  }

  void validateLocation() {
    if (country.isEmpty || state.isEmpty || city.isEmpty) {
      Get.snackbar('Error', 'Please select your country, state, and city.');
    }
  }

  void validateTermsAgreement() {
    if (!agreeToTerms) {
      Get.snackbar('Error', 'You must agree to the terms and conditions.');
    }
  }

  void validateForm() {
    if (formKey.currentState!.validate()) {
      signUp();
    } else {
      validateLocation();
      validateTermsAgreement();
    }
  }

  void signUp() {
    final isValidPassword = _validatePassword(passwordController.text);

    if (isValidPassword &&
        country.isNotEmpty &&
        state.isNotEmpty &&
        city.isNotEmpty &&
        agreeToTerms) {
      final user = UserModel(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phone: phoneController.text,
        country: country,
        state: state,
        city: city,
        birthday: birthdayController.text,
        password: passwordController.text,
      );

      // Save user data and navigate to email verification page
      // Assuming user data is saved successfully
      Get.to(() => EmailVerificationPage());
    } else {
      validateLocation();
      validateTermsAgreement();
    }
  }

  bool _validatePassword(String value) {
    if (value.length < 8) {
      Get.snackbar('Error', 'Password must be at least 8 characters long');
      return false;
    }
    if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+{}|:"<>?~\-\[\]\\;/=.,])')
        .hasMatch(value)) {
      Get.snackbar('Error',
          'Password must contain at least one uppercase letter, one lowercase letter, one digit, and one special character');
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    birthdayController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
