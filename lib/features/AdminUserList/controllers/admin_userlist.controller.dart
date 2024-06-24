import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/features/HomePage/screens/HomeScreen/home.dart';

class AdminUserListController extends GetxController {
  static AdminUserListController get instance => Get.find();

  void nextPage() {
    Get.offAll(const HomeScreen());
  }
}
