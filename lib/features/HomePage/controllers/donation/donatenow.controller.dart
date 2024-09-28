import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/curr_user.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/widgets/thanks_for_doantion_user.dart';
import '../../../../models/DonationModel/donation_tracker.dart';
import '../../../../models/UserModel/user_model.dart';
import '../../../../models/notificationModel/notification_model.dart';

class DonateNowController extends GetxController {
  var donationNeeded = 0.obs;
  var donationRaised = 0.obs;
  var selectedMethod = 'Bkash'.obs;
  var phoneNumber = ''.obs;
  var userId = ''.obs;
  var currUser = OneUser.currUserId;
  var userEmail = OneUser.currUserEmail;
  var postId = ''.obs;
  var isAnonymously = false.obs;
  var senderEmail = ''.obs;
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

        Get.to(() => const ThanksForDonationScreen());
      }
    } catch (e) {
      print('jahmela hocce donate korte user end a');
    }
  }

  Future<void> _updateDonationDetails(int donationAmount) async {
    final firestore = FirebaseFirestore.instance;

    getUserEmail(userId.value);

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
    final currentUserDoc = firestore.collection('Users').doc(currUser);
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

      transaction.update(seekerUserDoc, {
        'donationReceived': seekerUserDonationReceived + donationAmount,
      });
    });

    //donation tracker collection add a row
    DonationTracker newDonation = DonationTracker(
      donatorId: currUser,
      receiverId: userId.value,
      amount: donationAmount,
      type: 'user', // Adjust as necessary
      time: DateTime.now(),
      donationMedia: selectedMethod.value,
      postId: postId.value,
      isAnonymus: isAnonymously.value,
    );
    await firestore.collection('DonationTracker').add(newDonation.toMap());

    // Update local donationRaised value
    donationRaised.value += donationAmount;

    //send notification to users
    sendNotificationToUsers(donationAmount);
  }

  //send notifications
  Future<void> sendNotificationToUsers(int amount) async {
    final firestore = FirebaseFirestore.instance;
    try {
      final String notificationId = const Uuid().v4(); // Unique notification ID

      // Create a notification model for donator user
      NotificationModel notification1 = NotificationModel(
        message: 'You give $amount taka donation to a user.',
        title: 'Donation Given',
        timeStamp: DateTime.now(),
      );

      // Add notification to the senders's notifications collection
      await firestore
          .collection('Notifications')
          .doc(userEmail)
          .collection('UserNotifications')
          .doc(notificationId)
          .set(notification1.toMap());

      // Create a notification model for receiver user
      NotificationModel notification2 = NotificationModel(
        message: 'You have received $amount taka donation from a user.',
        title: 'Donation Received',
        timeStamp: DateTime.now(),
      );

      // Add notification to the receiver's notifications collection
      await firestore
          .collection('Notifications')
          .doc(senderEmail.value)
          .collection('UserNotifications')
          .doc(notificationId)
          .set(notification2.toMap());

      print('lol $userEmail ${senderEmail.value}');
    } catch (e) {
      throw Exception("Error sending notifications: $e");
    }
  }

  Future<void> getUserEmail(String userId) async {
    final firestore = FirebaseFirestore.instance;
    try {
      DocumentSnapshot userDoc =
          await firestore.collection('Users').doc(userId).get();
      if (userDoc.exists) {
        UserModel user =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        senderEmail.value = user.email;
      } else {
        Get.snackbar('Error', 'User not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user details: $e');
    }
  }
}
