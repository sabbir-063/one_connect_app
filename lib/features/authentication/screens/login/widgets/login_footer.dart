import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../controllers/login/google_login.controller.dart';


class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GoogleLoginController controller = Get.put(GoogleLoginController());
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'OR',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            SocialLoginButton(
              icon: FontAwesomeIcons.google,
              text: 'Continue with Google',
              onPressed: () {
                // Handle Google login
                controller.signInWithGoogle();
              },
            ),
            // const SizedBox(height: 16),
            // SocialLoginButton(
            //   icon: Icons.account_circle,
            //   text: 'Continue with Microsoft Account',
            //   onPressed: () {
            //     // Handle Microsoft login
            //   },
            // ),
            // const SizedBox(height: 16),
            // SocialLoginButton(
            //   icon: Icons.apple,
            //   text: 'Continue with Apple',
            //   onPressed: () {
            //     // Handle Apple login
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }
}
