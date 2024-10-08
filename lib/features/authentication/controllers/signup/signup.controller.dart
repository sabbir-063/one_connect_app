import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:one_connect_app/features/authentication/screens/login/login.dart';
import 'package:one_connect_app/utils/helpers/helper_functions.dart';
import '../../../../../models/UserModel/user_model.dart';
import '../../../../curr_user.dart';

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
          OneHelperFunctions.showCustomSnackBar(
              'Error', 'Email or phone number already in use.', false);
          return;
        }

        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        int currValue = 0;

        final centralFundDoc = FirebaseFirestore.instance
            .collection('CentralFund')
            .doc(OneUser.centralFundId);

        final centralFundSnapshot = await centralFundDoc.get();

        if (centralFundSnapshot.exists) {
          currValue = centralFundSnapshot.data()?['user_count'] ?? 0;
          await centralFundDoc.update({
            'user_count': currValue + 1,
          });
        }

        currValue++;
        int len = currValue.toString().length;
        int zeros = 8 - len;

        String userName = 'user_';

        for (int i = 0; i < zeros; i++) {
          userName += '0';
        }

        userName += currValue.toString();

        UserModel newUser = UserModel(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          userNameAuto: userName,
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
        OneHelperFunctions.showCustomSnackBar('Success', 'User registered successfully', true);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          OneHelperFunctions.showCustomSnackBar(
              'Error', 'The password provided is too weak.', false);
        } else if (e.code == 'email-already-in-use') {
          OneHelperFunctions.showCustomSnackBar(
              'Error', 'The account already exists for that email.', false);
        } else {
          OneHelperFunctions.showCustomSnackBar('Error',
              e.message ?? 'Firebase Auth Exception error occurred', false);
        }
      } catch (e) {
        OneHelperFunctions.showCustomSnackBar(
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
