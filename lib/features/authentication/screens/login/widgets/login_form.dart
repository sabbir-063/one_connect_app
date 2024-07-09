import 'package:one_connect_app/features/authentication/screens/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/login/login.controller.dart';

class OneForm extends StatelessWidget {
  OneForm({super.key});

  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginController.formKey,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: OneSizes.spaceBtwSections),
        child: Column(
          children: [
            // Email
            TextFormField(
              controller: _loginController.emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: OneTexts.email,
              ),
            ),
            const SizedBox(
              height: OneSizes.spaceBtwInputField,
            ),
            // Password
            Obx(
              () => TextFormField(
                controller: _loginController.passwordController,
                obscureText: _loginController.isPasswordHidden.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: OneTexts.password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _loginController.isPasswordHidden.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                    ),
                    onPressed: _loginController.togglePasswordVisibility,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: OneSizes.spaceBtwInputField / 2,
            ),
            // Remember Me and Forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(OneTexts.remember),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(OneTexts.forget),
                ),
              ],
            ),
            const SizedBox(
              height: OneSizes.spaceBtwItems,
            ),
            // Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loginController.login,
                child: const Text(OneTexts.signIn),
              ),
            ),
            const SizedBox(
              height: OneSizes.spaceBtwInputField,
            ),
            // Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignUpScreen()),
                child: const Text(OneTexts.createAcc),
              ),
            ),
            const SizedBox(
              height: OneSizes.spaceBtwSections / 2,
            ),
          ],
        ),
      ),
    );
  }
}
