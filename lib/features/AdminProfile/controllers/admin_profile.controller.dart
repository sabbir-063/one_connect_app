import 'package:get/get.dart';

import '../../authentication/screens/login/login.dart';

class AdminController extends GetxController {
  final String firstName = 'Shohan';
  final String lastName = 'Shovo';
  final String phone = '01860552999';
  final String email = 'waterhorse.08@gmail.com';

  void logout() {
    // Implement logout logic here, such as clearing session or navigating to login screen
    Get.offAll(() => const LoginScreen());
  }
}
