import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/UserModel/user_model.dart';
import '../controllers/admin_chat.controller.dart';

class AdminChatScreen extends StatelessWidget {
  final UserModel user;
  final AdminChatController controller = Get.put(AdminChatController());

  // AdminChatScreen({super.key, required UserModel user});
     AdminChatScreen({super.key, required this.user});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lastName}'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: Obx(() {
              return ListView.builder(
                reverse: true,
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  var message = controller.messages[index];
                  bool isAdmin = message.sender == 'admin';
                  return Align(
                    alignment:
                        isAdmin ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 8.0,
                      ),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: isAdmin
                            ? Colors.blue.shade100
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(message.content),
                    ),
                  );
                },
              );
            }),
          ),

          // Message input
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.messageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    controller.sendMessage('admin', user.email);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
