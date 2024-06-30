import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/edit_profile.controller.dart';

class EditProfileScreen extends StatelessWidget {
  final EditProfileController controller = Get.put(EditProfileController());

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: controller.firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  suffixIcon: Icon(Icons.lock),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  suffixIcon: Icon(Icons.lock),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.countryController,
                decoration: const InputDecoration(labelText: 'Country'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.stateController,
                decoration: const InputDecoration(labelText: 'State'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.cityController,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.birthdayController,
                decoration: const InputDecoration(labelText: 'Birthday'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.currentPasswordController,
                decoration:
                    const InputDecoration(labelText: 'Current Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.passwordController,
                decoration:
                    const InputDecoration(labelText: 'New Password (optional)'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Ensure profile is updated correctly and navigates back to profile screen
                  controller.updateProfile();
                  // print("h");
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
