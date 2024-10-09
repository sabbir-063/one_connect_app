import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:one_connect_app/curr_user.dart';
import 'package:one_connect_app/utils/helpers/helper_functions.dart';
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
          OneUser.currUserEmail = emailController.text;

          await userController.fetchUserData(userId);
          // If login is successful, save credentials
          await UserPreferences.saveUserCredentials(
              emailController.text, passwordController.text);
          // Navigate to the main application screen
          //basic notification
          AwesomeNotifications().createNotification(
              content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            // actionType: ActionType.Default,
            title: 'User Logged in!',
            body: 'You logged in succesfully to oneconnect app!',
          ));

          Get.offAll(() => const NavigationBarMenu());

          OneHelperFunctions.showCustomSnackBar(
              'Success', 'User logged in successfully', true);
        } else {
          OneHelperFunctions.showCustomSnackBar(
              'Error', 'Failed to retrieve user ID.', false);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          OneHelperFunctions.showCustomSnackBar(
              'Error', 'No user found for that email.', false);
        } else if (e.code == 'wrong-password') {
          OneHelperFunctions.showCustomSnackBar(
              'Error', 'Wrong password provided.', false);
        } else {
          OneHelperFunctions.showCustomSnackBar(
              'Error', e.message ?? 'An error occurred', false);
        }
      } catch (e) {
        OneHelperFunctions.showCustomSnackBar(
            'Error', 'An error occurred. Please try again.', false);
      }
    }
  }

  bool _validateInputs() {
    if (emailController.text.isEmpty) {
      OneHelperFunctions.showCustomSnackBar(
          'Error', 'Email cannot be empty', false);
      return false;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      OneHelperFunctions.showCustomSnackBar(
          'Error', 'Enter a valid email', false);
      return false;
    }
    if (passwordController.text.isEmpty) {
      OneHelperFunctions.showCustomSnackBar(
          'Error', 'Password cannot be empty', false);
      return false;
    }
    if (passwordController.text.length < 8) {
      OneHelperFunctions.showCustomSnackBar(
          'Error', 'Password must be at least 8 characters long', false);
      return false;
    }
    return true;
  }
}
