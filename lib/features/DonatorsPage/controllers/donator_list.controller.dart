import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/features/HomePage/screens/HomeScreen/home.dart';

import '../../../data/static_data/user_list/user_data2.dart';
import '../../../models/UserModel/user_model.dart';
import '../screens/widgets/user_rank.dart';


class DonatorListController extends GetxController {
  final _users = <UserModel>[].obs;
  final _filteredUsers = <UserModel>[].obs;
  final _searchQuery = ''.obs;
  String _sortBy = 'donationGiven'; // Default sort by donationGiven
  bool _sortAscending = false; // Default sort descending

  @override
  void onInit() {
    _users.assignAll(UserData2.users); // Initialize with all users
    _filteredUsers.assignAll(_users); // Initially show all users
    super.onInit();
  }

  List<UserModel> get users => _filteredUsers.toList();
  String get sortBy => _sortBy;
  bool get sortAscending => _sortAscending;

  void search(String query) {
    _searchQuery.value = query.toLowerCase();
    _applyFilter();
  }

  void setSortBy(String sortBy) {
    _sortBy = sortBy;
    _applyFilter();
  }

  void setSortAscending(bool ascending) {
    _sortAscending = ascending;
    _applyFilter();
  }

  void _applyFilter() {
    _filteredUsers.assignAll(_users.where((user) =>
        user.firstName.toLowerCase().contains(_searchQuery.value) ||
        user.lastName.toLowerCase().contains(_searchQuery.value) ||
        user.email.toLowerCase().contains(_searchQuery.value) ||
        user.phone.toLowerCase().contains(_searchQuery.value)));

    // Sort filtered users
    _filteredUsers.sort((a, b) {
      dynamic aValue, bValue;
      switch (_sortBy) {
        case 'name':
          aValue = '${a.firstName} ${a.lastName}';
          bValue = '${b.firstName} ${b.lastName}';
          break;
        case 'email':
          aValue = a.email;
          bValue = b.email;
          break;
        case 'phone':
          aValue = a.phone;
          bValue = b.phone;
          break;
        case 'donationGiven':
          aValue = a.donationGiven;
          bValue = b.donationGiven;
          break;
        case 'donationReceived':
          aValue = a.donationReceived;
          bValue = b.donationReceived;
          break;
        default:
          return 0;
      }
      if (_sortAscending) {
        return Comparable.compare(aValue, bValue);
      } else {
        return Comparable.compare(bValue, aValue);
      }
    });
  }

  UserRank getUserRank(int index) {
    if (index < 3) {
      return UserRank.Gold;
    } else if (index < 10) {
      return UserRank.Silver;
    } else if (index < 20) {
      return UserRank.Bronze;
    } else {
      return UserRank.None;
    }
  }
}
