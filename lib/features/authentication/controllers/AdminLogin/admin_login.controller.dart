import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:one_connect_app/curr_user.dart';
import '../../../../admin_navigation_bar.dart';
import '../../../../models/UserModel/admin_model.dart';

class AdminLoginController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
        final QuerySnapshot adminSnapshot = await _firestore
            .collection('Admins')
            .where('email', isEqualTo: emailController.text)
            .get();

        if (adminSnapshot.docs.isNotEmpty) {
          final adminData =
              adminSnapshot.docs.first.data() as Map<String, dynamic>;
          final AdminModel admin = AdminModel.fromMap(adminData);

          if (admin.password == passwordController.text) {
            OneUser.currAdminId = adminSnapshot.docs.first.id;
            // Navigate to the main application screen
            Get.offAll(() => const AdminNavigationBarMenu());

            showCustomSnackBar('Success', 'Admin logged in successfully', true);
          } else {
            showCustomSnackBar('Error', 'Invalid email or password.', false);
          }
        } else {
          showCustomSnackBar('Error', 'Admin not found.', false);
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
