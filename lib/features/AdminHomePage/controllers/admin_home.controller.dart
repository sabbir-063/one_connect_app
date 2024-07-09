
import 'package:get/get.dart';
import 'package:one_connect_app/features/HomePage/screens/HomeScreen/home.dart';

class AdminHomeController extends GetxController {
  static AdminHomeController get instance => Get.find();

  void nextPage() {
    Get.offAll(const HomeScreen());
  }
}
