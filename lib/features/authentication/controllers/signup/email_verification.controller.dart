import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../navigation_bar.dart';

class EmailVerificationController extends GetxController {
  var isCodeValid = true.obs;
  var errorMessage = ''.obs;
  TextEditingController codeController = TextEditingController();

  void verifyCode() {
    if (codeController.text == '123456') { // Assume '123456' is the correct code for demo purposes
      isCodeValid.value = true;
      errorMessage.value = '';
      Get.to(const NavigationBarMenu());
    } else {
      isCodeValid.value = false;
      errorMessage.value = 'Incorrect code. Please try again.';
      Future.delayed(const Duration(seconds: 3), () {
        isCodeValid.value = true;
        errorMessage.value = '';
      });
    }
  }

  @override
  void onClose() {
    codeController.dispose();
    super.onClose();
  }
}
