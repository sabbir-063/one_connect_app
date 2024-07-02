
import 'package:get/get.dart';


import '../../../data/static_data/user_list/user_data2.dart';
import '../../../models/UserModel/user_model.dart';

class AdminChatListController extends GetxController {
  var users = <UserModel>[].obs;
  var filteredUsers = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    users.value = UserData2.users;
    filteredUsers.value = users;
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredUsers.value = users;
    } else {
      filteredUsers.value = users.where((user) {
        return user.firstName.toLowerCase().contains(query.toLowerCase()) ||
            user.lastName.toLowerCase().contains(query.toLowerCase()) ||
            user.email.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }
}

