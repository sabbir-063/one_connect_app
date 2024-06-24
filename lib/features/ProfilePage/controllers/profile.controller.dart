import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/features/HomePage/screens/HomeScreen/home.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  void nextPage() {
    Get.offAll(const HomeScreen());
  }
}
