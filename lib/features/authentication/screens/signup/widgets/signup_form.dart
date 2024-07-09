import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:csc_picker/csc_picker.dart';
import '../../../controllers/signup/signup.controller.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          Row(
            children: [
              // First Name
              Expanded(
                child: TextFormField(
                  controller: controller.firstNameController,
                  decoration: const InputDecoration(
                    labelText: OneTexts.firstname,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: OneSizes.spaceBtwInputField),

              // Last Name
              Expanded(
                child: TextFormField(
                  controller: controller.lastNameController,
                  decoration: const InputDecoration(
                    labelText: OneTexts.lastname,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: OneSizes.spaceBtwInputField),

          // Email
          TextFormField(
            controller: controller.emailController,
            decoration: const InputDecoration(
              labelText: OneTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!GetUtils.isEmail(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),

          const SizedBox(height: OneSizes.spaceBtwInputField),

          // Phone Number
          TextFormField(
            controller: controller.phoneController,
            decoration: const InputDecoration(
              labelText: OneTexts.phone,
              prefixIcon: Icon(Iconsax.call),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              if (!RegExp(r'^01\d{9}$').hasMatch(value)) {
                return 'Phone number must start with 01 and be 11 digits long';
              }
              return null;
            },
          ),

          const SizedBox(height: OneSizes.spaceBtwInputField),

          // Country, State, City
          CSCPicker(
            flagState: CountryFlag.DISABLE,
            onCountryChanged: (value) {
              controller.country = value;
            },
            onStateChanged: (value) {
              controller.state = value ?? '';
            },
            onCityChanged: (value) {
              controller.city = value ?? '';
            },
            selectedItemStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: OneSizes.spaceBtwInputField),

          // Birthday
          TextFormField(
            controller: controller.birthdayController,
            decoration: const InputDecoration(
              labelText: 'Birthday',
              prefixIcon: Icon(Iconsax.calendar),
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );

              if (pickedDate != null) {
                controller.birthdayController.text =
                    '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your birthday';
              }
              return null;
            },
          ),

          const SizedBox(height: OneSizes.spaceBtwInputField),

          // Password
          Obx(() => TextFormField(
                controller: controller.passwordController,
                obscureText: controller.isPasswordHidden.value,
                decoration: InputDecoration(
                  labelText: OneTexts.password,
                  prefixIcon: const Icon(Iconsax.arrow_right),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordHidden.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  if (!RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+{}|:"<>?~\-\[\]\\;/=.,])')
                      .hasMatch(value)) {
                    return 'Password must contain at least one uppercase letter, one lowercase letter, one digit, and one special character';
                  }
                  return null;
                },
              )),

          const SizedBox(height: OneSizes.spaceBtwSections),

          // Sign Up
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                controller.validateForm();
              },
              child: const Text(OneTexts.signUp),
            ),
          ),
        ],
      ),
    );
  }
}
