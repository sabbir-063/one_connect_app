import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../models/UserModel/user_model.dart';

class AdminChatListController extends GetxController {
  var users = <UserModel>[].obs;
  var filteredUsers = <UserModel>[].obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchAllUsers();
  }

  Future<void> fetchAllUsers() async {
    try {
      final userDocs = await _firestore.collection('Users').get();
      users.value = userDocs.docs
          .map((doc) => UserModel(
                firstName: doc['firstName'],
                lastName: doc['lastName'],
                email: doc['email'],
                phone: doc['phone'],
                country: doc['country'],
                state: doc['state'],
                city: doc['city'],
                birthday: doc['birthday'],
                password: doc['password'],
                donationGiven: doc['donationGiven'],
                donationReceived: doc['donationReceived'],
                profileUrl: doc['profileUrl'],
              ))
          .toList();

      filteredUsers.value = users;
    } catch (e) {
      print("Error fetching users: $e");
    }
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
