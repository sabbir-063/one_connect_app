import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat.controller.dart';
import 'chat.dart';

class MessagesScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Handle new chat creation or navigation to chat editor
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search by Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (query) {
                chatController.searchUsers(query);
              },
            ),
          ),
          Expanded(
            child: Obx(
              () => chatController.chats.isEmpty
                  ? const Center(child: Text('No chats yet'))
                  : ListView.builder(
                      itemCount: chatController.chats.length,
                      itemBuilder: (context, index) {
                        final chat = chatController.chats[index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(chat.user.firstName[0]),
                          ),
                          title: Text(
                              '${chat.user.firstName} ${chat.user.lastName}'),
                          subtitle: Text(chat.lastMessage),
                          trailing: Text(
                            '${chat.timestamp.hour}:${chat.timestamp.minute}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          onTap: () {
                            // Navigate to the chat screen with this user
                            Get.to(() => ChatScreen(user: chat.user));
                          },
                        );
                      },
                    ),
            ),
          ),
          Expanded(
            child: Obx(
              () => chatController.searchResults.isEmpty
                  ? const SizedBox.shrink()
                  : ListView.builder(
                      itemCount: chatController.searchResults.length,
                      itemBuilder: (context, index) {
                        final user = chatController.searchResults[index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(user.firstName[0]),
                          ),
                          title: Text('${user.firstName} ${user.lastName}'),
                          subtitle: Text(user.email),
                          onTap: () {
                            chatController.startChat(user);
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
