import 'package:get/get.dart';

class DonateNowController extends GetxController {
  final RxString selectedMethod = 'Bkash'.obs;
  final RxInt donationNeeded = 0.obs;
  final RxInt donationRaised = 0.obs;

  void updateSelectedMethod(String? method) {
    if (method != null) {
      selectedMethod.value = method;
    }
  }
}
