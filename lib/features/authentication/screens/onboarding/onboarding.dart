import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/utils/constants/image_strings.dart';

import '../login/login.dart';
import '../signup/signup.dart';

// class OnBoardingScreen extends StatelessWidget {
//   const OnBoardingScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Text("Hello World"),
//     );
//   }
// }
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // One Connect logo
            Center(
              child: Image.asset(
                OneImages.lightAppLogo,
                height: 150,
                width: 150,
              ),
            ),
            const SizedBox(height: 30),

            // Title
            const Text(
              'Explore the app',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Subtitle
            Text(
              'Now your finances are in one place\nand always under control',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 40),

            // Sign In button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () => Get.to(()=>const LoginScreen()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Center(
                  child: Text('Sign In'),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Create account button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: OutlinedButton(
                onPressed: () =>Get.to(() => const SignUpScreen()),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                  side: const BorderSide(color: Colors.black),
                ),
                child: const Center(
                  child: Text(
                    'Create account',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}