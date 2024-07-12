import 'package:get/get.dart';
import 'package:one_connect_app/common/styles/spacing_styles.dart';

import 'package:flutter/material.dart';
import 'package:one_connect_app/utils/constants/sizes.dart';

import '../login/login.dart';
import 'widgets/admin_login_form.dart';
import 'widgets/admin_login_title.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: OneSpacingStyles.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// login, title, sub title
              const AdminLoginTitle(),

              /// Form
              AdminLoginForm(),

              const SizedBox(height: OneSizes.spaceBtwItems),

              GestureDetector(
                onTap: () {
                  Get.offAll(() => const LoginScreen());
                },
                child: const Text(
                  "Login as User",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                    // fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    decorationThickness: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
