import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../models/UserModel/user_model.dart';

class DonatorListController extends GetxController {
  var users = <UserModel>[].obs;
  var filteredUsers = <UserModel>[].obs;
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
    applySearch();
  }

  void applySearch() {
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

    filteredUsers.value = allUsers;
  }

  void search(String query) {
    searchText.value = query;
    applySearch();
  }
}
