import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/curr_user.dart';

import '../../controllers/edit_profile.controller.dart';

class EditProfileScreen extends StatelessWidget {
  final EditProfileController controller = Get.put(EditProfileController());


  EditProfileScreen({super.key}) {
    controller.fetchUserData(OneUser.currUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.loggedUser.value.firstName.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                TextField(
                  controller: TextEditingController(
                      text: controller.loggedUser.value.firstName),
                  decoration: const InputDecoration(labelText: 'First Name'),
                  onChanged: (value) =>
                      controller.loggedUser.value.firstName = value,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: TextEditingController(
                      text: controller.loggedUser.value.lastName),
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  onChanged: (value) =>
                      controller.loggedUser.value.lastName = value,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: TextEditingController(
                      text: controller.loggedUser.value.country),
                  decoration: const InputDecoration(labelText: 'Country'),
                  onChanged: (value) =>
                      controller.loggedUser.value.country = value,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: TextEditingController(
                      text: controller.loggedUser.value.state),
                  decoration: const InputDecoration(labelText: 'State'),
                  onChanged: (value) =>
                      controller.loggedUser.value.state = value,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: TextEditingController(
                      text: controller.loggedUser.value.city),
                  decoration: const InputDecoration(labelText: 'City'),
                  onChanged: (value) =>
                      controller.loggedUser.value.city = value,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: TextEditingController(
                      text: controller.loggedUser.value.birthday),
                  decoration: const InputDecoration(labelText: 'Birthday'),
                  enabled: false,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: TextEditingController(
                      text: controller.loggedUser.value.email),
                  decoration: const InputDecoration(labelText: 'Email'),
                  enabled: false,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: TextEditingController(
                      text: controller.loggedUser.value.phone),
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  enabled: false,
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration:
                      const InputDecoration(labelText: 'Current Password'),
                  obscureText: true,
                  onChanged: (value) =>
                      controller.currentPassword.value = value,
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(labelText: 'New Password'),
                  obscureText: true,
                  onChanged: (value) => controller.newPassword.value = value,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => controller.updateUserProfile(),
                  child: const Text('Update Profile'),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
