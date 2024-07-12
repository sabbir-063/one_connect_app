import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/AdminLogin/admin_login.controller.dart';

class AdminLoginForm extends StatelessWidget {
  AdminLoginForm({super.key});

  final AdminLoginController _loginController = Get.put(AdminLoginController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginController.formKey,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: OneSizes.spaceBtwSections),
        child: Column(
          children: [
            //Email
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
            //Password
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
              height: OneSizes.spaceBtwItems,
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loginController.login,
                child: const Text(OneTexts.signIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
