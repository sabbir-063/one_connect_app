import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../curr_user.dart';
import '../../../models/DonationModel/donation_tracker.dart';
import '../../../models/UserModel/user_model.dart';
import '../../../models/notificationModel/notification_model.dart';
import '../../AdminProfile/controllers/admin_profile.controller.dart';
import '../screens/donation_confirmation.dart';

class DonationController extends GetxController {
  final amountController = TextEditingController();
  var selectedMethod = 'Bkash'.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
        int currValue2 =
            centralFundSnapshot.data()?['totalRemainingCapital'] ?? 0;
        await centralFundDoc.update({
          'totalRemainingCapital': currValue2 + amount,
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

      //donation tracker collection add a row
      DonationTracker newDonation = DonationTracker(
        donatorId: OneUser.currUserId,
        receiverId: OneUser.centralFundId,
        amount: amount,
        type: 'Central Fund regular', // Adjust as necessary
        time: DateTime.now(),
        donationMedia: selectedMethod.value,
        postId: '0',
      );
      await FirebaseFirestore.instance
          .collection('DonationTracker')
          .add(newDonation.toMap());

      final AdminController controller3 = Get.put(AdminController());
      controller3.updateAdminValue();
      sendNotification(amount);
    } catch (e) {
      // print("Error updating central fund: $e");
    }
  }

  Future<void> sendNotification(int amount) async {
    try {
      final String email = await getUserEmail(OneUser.currUserId);

      NotificationModel notification1 = NotificationModel(
        message:
            'You donated $amount Taka in Central Fund. Thanks for donating.',
        title: 'Donated in Central Fund',
        timeStamp: DateTime.now(),
      );
      //add notification
      await firestore
          .collection('Notifications')
          .doc(email)
          .collection('UserNotifications')
          .add(notification1.toMap());
    } catch (e) {
      print('Error sending central fund donation notification : $e');
    }
  }

  Future<String> getUserEmail(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await firestore.collection('Users').doc(userId).get();
      if (userDoc.exists) {
        UserModel user =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        return user.email;
      } else {
        // Get.snackbar('Error', 'User not found');
        return '';
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user details: $e');
      return '';
    }
  }
}
