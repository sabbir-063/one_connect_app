import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/curr_user.dart';

import '../../../../common/widgets/thanks_for_doantion_user.dart';
import '../../../../models/DonationModel/donation_tracker.dart';

class AdminDonateNowController extends GetxController {
  var donationNeeded = 0.obs;
  var donationRaised = 0.obs;
  var selectedMethod = 'Bkash'.obs;
  var phoneNumber = ''.obs;
  var userId = 'hBLwTdq4OXdsR6CcjE6F'.obs;
  var currUser = OneUser.currUserId;
  var postId = ''.obs;
  final amountController = TextEditingController();

  void updateSelectedMethod(String? method) {
    if (method != null) {
      selectedMethod.value = method;
    }
  }

  Future<void> validateDonationAmount() async {
    try {
      int maxAmount = donationNeeded.value - donationRaised.value;
      int donationAmount = int.tryParse(amountController.text) ?? 0;

      if (donationAmount <= 0 || donationAmount > maxAmount) {
        Get.snackbar('Error', 'Please enter a valid amount (1 - $maxAmount)');
      } else {
        // Navigate to Thanks for Donation page
        await _updateDonationDetails(donationAmount);

        print('sob thik hoise special admin donation');

        Get.to(() => const ThanksForDonationScreen());
      }
    } catch (e) {
      print('jahmela hocce donate korte user end a');
    }
  }

  Future<void> _updateDonationDetails(int donationAmount) async {
    final firestore = FirebaseFirestore.instance;

    // Update donationRaised in the Posts collection
    final postDoc = firestore.collection('AdminPosts').doc(postId.value);
    final postSnapshot = await postDoc.get();
    if (postSnapshot.exists) {
      int currentDonationRaised = postSnapshot.data()?['donationRaised'] ?? 0;
      await postDoc.update({
        'donationRaised': currentDonationRaised + donationAmount,
      });
    }

    // Update donationGiven and donationReceived in the Users collection
    final currentUserDoc = firestore.collection('Users').doc(currUser);
    final seekerUserDoc = firestore.collection('CentralFund').doc(userId.value);

    await firestore.runTransaction((transaction) async {
      final currentUserSnapshot = await transaction.get(currentUserDoc);
      final seekerUserSnapshot = await transaction.get(seekerUserDoc);

      if (!currentUserSnapshot.exists || !seekerUserSnapshot.exists) {
        throw Exception('User does not exist');
      }

      int currentUserDonationGiven =
          currentUserSnapshot.data()?['donationGiven'] ?? 0;
      int seekerUserDonationReceived =
          seekerUserSnapshot.data()?['specialFundRaised'] ?? 0;

      transaction.update(currentUserDoc, {
        'donationGiven': currentUserDonationGiven + donationAmount,
      });

      transaction.update(seekerUserDoc, {
        'specialFundRaised': seekerUserDonationReceived + donationAmount,
      });
    });

    //donation tracker collection add a row
    DonationTracker newDonation = DonationTracker(
      donatorId: currUser,
      receiverId: userId.value,
      amount: donationAmount,
      type: 'Central Fund special', // Adjust as necessary
      time: DateTime.now(),
      donationMedia: selectedMethod.value,
      postId: postId.value,
    );
    await firestore.collection('DonationTracker').add(newDonation.toMap());

    // Update local donationRaised value
    donationRaised.value += donationAmount;
  }
}
