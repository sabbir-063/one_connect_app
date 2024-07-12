import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../curr_user.dart';
import '../screens/donation_confirmation.dart';

class DonationController extends GetxController {
  final amountController = TextEditingController();
  var selectedMethod = 'Bkash'.obs;

  void setSelectedMethod(String method) {
    selectedMethod.value = method;
  }

  Future<void> handleDonation() async {
    if (amountController.text.isNotEmpty) {
      int amount = int.parse(amountController.text);
      if (amount > 0) {
        await addAmountToCentralFund(amount);
        Get.to(() => const DonationConfirmationPage());
      } else {
        Get.snackbar('Invalid Amount', 'Please enter an amount greater than 0');
      }
    } else {
      Get.snackbar('Empty Field', 'Please enter a donation amount');
    }
  }

  Future<void> addAmountToCentralFund(int amount) async {
    try {
      //central fund update
      final centralFundDoc = FirebaseFirestore.instance
          .collection('CentralFund')
          .doc(OneUser.centralFundId);

      final centralFundSnapshot = await centralFundDoc.get();

      if (centralFundSnapshot.exists) {
        int currValue = centralFundSnapshot.data()?['fundRaised'] ?? 0;
        await centralFundDoc.update({
          'fundRaised': currValue + amount,
        });
      }

      //user donationGiven update
      final userDoc = FirebaseFirestore.instance
          .collection('Users')
          .doc(OneUser.currUserId);

      final userSnapshot = await userDoc.get();

      if (userSnapshot.exists) {
        int currValue = userSnapshot.data()?['donationGiven'] ?? 0;
        await userDoc.update({
          'donationGiven': currValue + amount,
        });
      }
    } catch (e) {
      // print("Error updating central fund: $e");
    }
  }
}
