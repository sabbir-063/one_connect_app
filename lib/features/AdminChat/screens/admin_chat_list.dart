import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/admin_chat_list.controller.dart';
import 'admin_chat.dart';


class AdminChatListScreen extends StatelessWidget {
  final AdminChatListController controller = Get.put(AdminChatListController());

  AdminChatListScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat List'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                onChanged: controller.search,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: 'Search users',
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Chat List
            Expanded(
              child: Obx(() {
                if (controller.filteredUsers.isEmpty) {
                  return const Center(child: Text('No users found.'));
                }
                return ListView.builder(
                  itemCount: controller.filteredUsers.length,
                  itemBuilder: (context, index) {
                    var user = controller.filteredUsers[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(user.firstName[0]),
                      ),
                      title: Text('${user.firstName} ${user.lastName}'),
                      subtitle: Text(user.email),
                      onTap: () {
                        Get.to(() => AdminChatScreen(user: user));
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
