import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/UserModel/user_model.dart';
import '../controllers/admin_chat.controller.dart';
import '../../../utils/constants/colors.dart';

class AdminChatScreen extends StatelessWidget {
  final UserModel user;
  final AdminChatController controller = Get.put(AdminChatController());

  AdminChatScreen({super.key, required this.user}) {
    controller.initialize(user.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lastName}'),
        backgroundColor: OneColors.accent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.messages.isEmpty) {
                return const Center(child: Text('No messages yet.'));
              }

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
                        horizontal: 18.0,
                      ),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: isAdmin
                            ? Colors.blue.shade500
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(message.content),
                          const SizedBox(height: 4),
                          Text(
                            '${message.timestamp.hour}:${message.timestamp.minute}',
                            style: TextStyle(
                              fontSize: 10,
                              color: isAdmin ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          // Message input
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 12, 8, 15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.messageController,
                    minLines: 1,
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
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
                    controller.sendMessage('admin');
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
