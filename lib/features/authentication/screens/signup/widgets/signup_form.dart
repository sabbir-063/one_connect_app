import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'email_verification.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = OneHelperFunctions.isDarkMode(context);
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              //first name
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: OneTexts.firstname,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: OneSizes.spaceBtwInputField),

              //last name
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: OneTexts.lastname,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: OneSizes.spaceBtwInputField),

          //user name
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
              labelText: OneTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),

          const SizedBox(height: OneSizes.spaceBtwInputField),

          //email
          TextFormField(
            decoration: const InputDecoration(
              labelText: OneTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),

          const SizedBox(height: OneSizes.spaceBtwInputField),

          //phone number
          TextFormField(
            decoration: const InputDecoration(
              labelText: OneTexts.phone,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),

          const SizedBox(height: OneSizes.spaceBtwInputField),

          //password
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: OneTexts.password,
              prefixIcon: Icon(Iconsax.arrow_right),
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
          ),

          const SizedBox(height: OneSizes.spaceBtwSections),

          ///terms and condition n
          Row(
            children: [
              SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(value: true, onChanged: (value) {})),
              const SizedBox(width: OneSizes.spaceBtwItems),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: '${OneTexts.iAgreeto} ',
                        style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(
                      text: '${OneTexts.privacy} ',
                      style: Theme.of(context).textTheme.bodySmall!.apply(
                            color: dark ? OneColors.white : OneColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                dark ? OneColors.white : OneColors.primary,
                          ),
                    ),
                    TextSpan(
                        text: '${OneTexts.and} ',
                        style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(
                      text: OneTexts.termsofuse,
                      style: Theme.of(context).textTheme.bodySmall!.apply(
                            color: dark ? OneColors.white : OneColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                dark ? OneColors.white : OneColors.primary,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: OneSizes.spaceBtwSections),

          ///Sign Up
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to(()=> EmailVerificationPage()),
              child: const Text(OneTexts.signUp),
            ),
          ),
        ],
      ),
    );
  }
}
