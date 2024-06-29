import 'package:get/get.dart';

import '../../../data/static_data/user_list/user_data.dart';
import '../../../models/UserModel/user_model.dart';

class Chat {
  final UserModel user;
  final String lastMessage;
  final DateTime timestamp;

  Chat(
      {required this.user, required this.lastMessage, required this.timestamp});
}

class ChatController extends GetxController {
  var chats = <Chat>[].obs;
  var users = UserData.users;
  var searchResults = <UserModel>[].obs;

  void startChat(UserModel user) {
    if (!chats.any((chat) => chat.user.email == user.email)) {
      chats.add(Chat(
        user: user,
        lastMessage: 'Start chatting with ${user.firstName}',
        timestamp: DateTime.now(),
      ));
    }
  }

  void searchUsers(String query) {
    if (query.isEmpty) {
      searchResults.clear();
    } else {
      searchResults.value = users.where((user) {
        final fullName = '${user.firstName} ${user.lastName}'.toLowerCase();
        return fullName.contains(query.toLowerCase());
      }).toList();
    }
  }
}
