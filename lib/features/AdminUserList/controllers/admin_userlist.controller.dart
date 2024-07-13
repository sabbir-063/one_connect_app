import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../models/UserModel/user_model.dart';

class AdminUserController extends GetxController {
  var users = <UserModel>[].obs;
  var filteredUsers = <UserModel>[].obs;
  var currentPage = 1.obs;
  var usersPerPage = 10;
  var searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Users').get();
    if (querySnapshot.docs.isNotEmpty) {
      users.assignAll(querySnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList());
    }

    users.sort((a, b) => b.donationGiven.compareTo(a.donationGiven));
    assignRanks();
    applySearchAndPagination();
  }

  void assignRanks() {
    for (int i = 0; i < users.length; i++) {}
  }

  void applySearchAndPagination() {
    List<UserModel> allUsers = users;

    if (searchText.isNotEmpty) {
      allUsers = allUsers.where((user) {
        return user.firstName
                .toLowerCase()
                .contains(searchText.value.toLowerCase()) ||
            user.lastName
                .toLowerCase()
                .contains(searchText.value.toLowerCase()) ||
            user.email.toLowerCase().contains(searchText.value.toLowerCase()) ||
            user.country
                .toLowerCase()
                .contains(searchText.value.toLowerCase()) ||
            user.city.toLowerCase().contains(searchText.value.toLowerCase());
      }).toList();
    }

    filteredUsers.value = allUsers
        .skip((currentPage.value - 1) * usersPerPage)
        .take(usersPerPage)
        .toList();
  }

  void search(String query) {
    searchText.value = query;
    currentPage.value = 1;
    applySearchAndPagination();
  }

  void nextPage() {
    if (currentPage.value * usersPerPage < users.length) {
      currentPage.value++;
      applySearchAndPagination();
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
      applySearchAndPagination();
    }
  }
}
