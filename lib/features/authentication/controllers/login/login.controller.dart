import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:one_connect_app/curr_user.dart';
import '../../../../../navigation_bar.dart';
import '../../../../common/userCredentials/user_preferences.dart';
import '../../../ProfilePage/controllers/profile.controller.dart';

class LoginController extends GetxController {
  final ProfileController userController = Get.put(ProfileController());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isPasswordHidden = true.obs;

  var userCredentials = <Map<String, String>>[].obs;
  var selectedEmail = ''.obs;
  var selectedPassword = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserCredentials();
  }

  Future<void> _loadUserCredentials() async {
    final credentials = await UserPreferences.getUserCredentials();
    userCredentials.value = credentials;
    update([
      'credentialsDropdown'
    ]); // Update the dropdown after loading credentials
  }

  void onCredentialSelected(Map<String, String> credential) {
    selectedEmail.value = credential['email']!;
    selectedPassword.value = credential['password']!;
    emailController.text = selectedEmail.value;
    passwordController.text = selectedPassword.value;
    update(['emailField', 'passwordField']); // Update email and password fields
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
    update(['passwordField']); // Update password field visibility
  }

  void login() async {
    if (_validateInputs()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Fetch user data after successful login
        final String userId = userCredential.user?.uid ?? '';
        if (userId.isNotEmpty) {
          // Initialize ProfileController and fetch user data
          OneUser.currUserId = userId;
          await userController.fetchUserData(userId);
          // If login is successful, save credentials
          await UserPreferences.saveUserCredentials(
              emailController.text, passwordController.text);
          // Navigate to the main application screen
          Get.offAll(() => const NavigationBarMenu());

          showCustomSnackBar('Success', 'User logged in successfully', true);
        } else {
          showCustomSnackBar('Error', 'Failed to retrieve user ID.', false);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showCustomSnackBar('Error', 'No user found for that email.', false);
        } else if (e.code == 'wrong-password') {
          showCustomSnackBar('Error', 'Wrong password provided.', false);
        } else {
          showCustomSnackBar('Error', e.message ?? 'An error occurred', false);
        }
      } catch (e) {
        showCustomSnackBar(
            'Error', 'An error occurred. Please try again.', false);
      }
    }
  }

  bool _validateInputs() {
    if (emailController.text.isEmpty) {
      showCustomSnackBar('Error', 'Email cannot be empty', false);
      return false;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      showCustomSnackBar('Error', 'Enter a valid email', false);
      return false;
    }
    if (passwordController.text.isEmpty) {
      showCustomSnackBar('Error', 'Password cannot be empty', false);
      return false;
    }
    if (passwordController.text.length < 8) {
      showCustomSnackBar(
          'Error', 'Password must be at least 8 characters long', false);
      return false;
    }
    return true;
  }

  void showCustomSnackBar(String title, String message, bool isSuccess) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      barBlur: 0,
      animationDuration: const Duration(milliseconds: 300),
      forwardAnimationCurve: Curves.easeOut,
      reverseAnimationCurve: Curves.easeIn,
      mainButton: TextButton(
        onPressed: () {
          Get.back(); // Close the snackbar
        },
        child: const Text(
          'Dismiss',
          style: TextStyle(color: Colors.white),
        ),
      ),
      isDismissible: true,
      showProgressIndicator: true,
      progressIndicatorValueColor:
          const AlwaysStoppedAnimation<Color>(Colors.white),
      progressIndicatorBackgroundColor: Colors.grey,
    );
  }
}
