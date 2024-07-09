import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:one_connect_app/admin_navigation_bar.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class AdminLoginForm extends StatelessWidget {
  const AdminLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: OneSizes.spaceBtwSections),
        child: Column(
          children: [
            //Email
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: OneTexts.email,
              ),
            ),
            const SizedBox(
              height: OneSizes.spaceBtwInputField,
            ),
            //Password
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: OneTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash),
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

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const AdminNavigationBarMenu()),
                child: const Text(OneTexts.signIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
