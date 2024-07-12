import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/thanks_for_donation.dart';
import '../../../curr_user.dart';

class DonateNowController extends GetxController {
  var donationNeeded = 0.obs;
  var donationRaised = 0.obs;
  var selectedMethod = 'Bkash'.obs;
  var phoneNumber = ''.obs;
  var userId = ''.obs;
  var currUser = OneUser.centralFundId;
  var postId = ''.obs;
  final amountController = TextEditingController();

  void updateSelectedMethod(String? method) {
    if (method != null) {
      selectedMethod.value = method;
    }
  }

  Future<void> validateDonationAmount() async {
    int maxAmount = donationNeeded.value - donationRaised.value;
    int donationAmount = int.tryParse(amountController.text) ?? 0;
    final centralFundDoc =
        FirebaseFirestore.instance.collection('CentralFund').doc(currUser);
    final centralFundSnapshot = await centralFundDoc.get();

    int centralGiven = centralFundSnapshot.data()?['donationGiven'] ?? 0;
    int centralRaised = centralFundSnapshot.data()?['fundRaised'] ?? 0;
    int centralRemaining = centralRaised - centralGiven;

    if (donationAmount <= 0 || donationAmount > maxAmount) {
      Get.snackbar('Error', 'Please enter a valid amount (1 - $maxAmount)');
    } else if (donationAmount > centralRemaining) {
      Get.snackbar('Error', 'Central Fund have insufficient balance');
    } else {
      // Navigate to Thanks for Donation page
      await _updateDonationDetails(donationAmount, centralRemaining);
      Get.to(() => const ThanksForDonationPage());
    }
  }

  Future<void> _updateDonationDetails(
      int donationAmount, int centralRemaining) async {
    final firestore = FirebaseFirestore.instance;

    // Update donationRaised in the Posts collection
    final postDoc = firestore.collection('Posts').doc(postId.value);
    final postSnapshot = await postDoc.get();
    if (postSnapshot.exists) {
      int currentDonationRaised = postSnapshot.data()?['donationRaised'] ?? 0;
      await postDoc.update({
        'donationRaised': currentDonationRaised + donationAmount,
      });
    }

    // Update donationGiven and donationReceived in the Users collection
    final currentUserDoc = firestore.collection('CentralFund').doc(currUser);
    final seekerUserDoc = firestore.collection('Users').doc(userId.value);

    await firestore.runTransaction((transaction) async {
      final currentUserSnapshot = await transaction.get(currentUserDoc);
      final seekerUserSnapshot = await transaction.get(seekerUserDoc);

      if (!currentUserSnapshot.exists || !seekerUserSnapshot.exists) {
        throw Exception('User does not exist');
      }

      int currentUserDonationGiven =
          currentUserSnapshot.data()?['donationGiven'] ?? 0;
      int seekerUserDonationReceived =
          seekerUserSnapshot.data()?['donationReceived'] ?? 0;

      transaction.update(currentUserDoc, {
        'donationGiven': currentUserDonationGiven + donationAmount,
      });

      transaction.update(currentUserDoc, {
        'totalRemainingCapital': currentUserDonationGiven - donationAmount,
      });

      transaction.update(seekerUserDoc, {
        'donationReceived': seekerUserDonationReceived + donationAmount,
      });
    });

    // Update local donationRaised value
    donationRaised.value += donationAmount;
  }
}
