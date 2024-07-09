import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../navigation_bar.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() async {
    if (_validateInputs()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        print("Signed in: ${userCredential.user?.email}");

        Get.offAll(() => const NavigationBarMenu());

        showCustomSnackBar('Success', 'User logged in successfully', true);
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

  // @override
  // void onClose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.onClose();
  // }
}
