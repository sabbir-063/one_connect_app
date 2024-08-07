import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:one_connect_app/features/authentication/screens/login/login.dart';
import '../../../../../models/UserModel/user_model.dart';

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
  var isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> validateForm() async {
    if (formKey.currentState!.validate()) {
      try {
        if (await _isEmailOrPhoneNumberUsed()) {
          showCustomSnackBar(
              'Error', 'Email or phone number already in use.', false);
          return;
        }

        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        UserModel newUser = UserModel(
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

        await saveUserToFirestore(userCredential.user!.uid, newUser);

        Get.offAll(() => const LoginScreen());
        showCustomSnackBar('Success', 'User registered successfully', true);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showCustomSnackBar(
              'Error', 'The password provided is too weak.', false);
        } else if (e.code == 'email-already-in-use') {
          showCustomSnackBar(
              'Error', 'The account already exists for that email.', false);
        } else {
          showCustomSnackBar('Error',
              e.message ?? 'Firebase Auth Exception error occurred', false);
        }
      } catch (e) {
        showCustomSnackBar(
            'Error', 'An error occurred. Please try again.', false);
      }
    }
  }

  Future<bool> _isEmailOrPhoneNumberUsed() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: emailController.text)
        .get();

    final QuerySnapshot phoneResult = await FirebaseFirestore.instance
        .collection('Users')
        .where('phone', isEqualTo: phoneController.text)
        .get();

    return result.docs.isNotEmpty || phoneResult.docs.isNotEmpty;
  }

  Future<void> saveUserToFirestore(String uid, UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .set(user.toMap());
    } catch (e) {
      throw Exception('Failed to save user data');
    }
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
      progressIndicatorValueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
      progressIndicatorBackgroundColor: Colors.grey,
    );
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
