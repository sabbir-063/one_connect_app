import 'package:get/get.dart';
import '../../../data/static_data/user_list/user_data2.dart';
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

  void fetchUsers() {
    users.value = UserData2.users;
    users.sort((a, b) => b.donationGiven.compareTo(a.donationGiven));
    assignRanks();
    applySearchAndPagination();
  }

  void assignRanks() {
    for (int i = 0; i < users.length; i++) {
      if (i == 0) {
        users[i].rank = UserRank.Gold;
      } else if (i == 1 || i == 2) {
        users[i].rank = UserRank.Silver;
      } else if (i < 10) {
        users[i].rank = UserRank.Bronze;
      } else {
        users[i].rank = UserRank.None;
      }
    }
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
