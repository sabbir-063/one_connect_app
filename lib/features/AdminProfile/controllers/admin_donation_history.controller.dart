import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../curr_user.dart';
import '../../../models/DonationModel/donation_tracker.dart';

class AdminDonationHistoryController extends GetxController {
  var donations = <DonationTracker>[].obs;
  var filteredDonations = <DonationTracker>[].obs;
  var startDate = DateTime.now().subtract(const Duration(days: 30)).obs;
  var endDate = DateTime.now().obs;

  // Map to store the receiver's full name
  var receiverNames = <String, String>{}.obs;

  Future<void> fetchData() async {
    final firestore = FirebaseFirestore.instance;

    try {
      final snapshot = await firestore
          .collection('DonationTracker')
          .where('donatorId', isEqualTo: OneUser.centralFundId)
          .get();

      final fetchedDonations = snapshot.docs.map((doc) {
        return DonationTracker.fromMap(doc.data());
      }).toList();

      donations.value = fetchedDonations;
      await _fetchReceiverNames();
      filterDonations();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch donation history: $e');
    }
  }

  Future<void> _fetchReceiverNames() async {
    final firestore = FirebaseFirestore.instance;

    for (var donation in donations) {
      if (!receiverNames.containsKey(donation.receiverId)) {
        try {
          final userDoc = await firestore
              .collection('Users')
              .doc(donation.receiverId)
              .get();
          if (userDoc.exists) {
            String firstName = userDoc.data()?['firstName'] ?? '';
            String lastName = userDoc.data()?['lastName'] ?? '';
            receiverNames[donation.receiverId] = '$firstName $lastName';
          } else {
            receiverNames[donation.receiverId] = 'User not found';
          }
        } catch (e) {
          receiverNames[donation.receiverId] = 'Error retrieving user name';
        }
      }
    }
  }

  String getReceiverFullName(String userId) {
    return receiverNames[userId] ?? 'Unknown';
  }

  void filterDonations() {
    DateTime start = startDate.value;
    DateTime end = endDate.value;

    filteredDonations.value = donations.where((donation) {
      return donation.time.isAfter(start) &&
          donation.time.isBefore(end.add(const Duration(days: 1)));
    }).toList();

    filteredDonations.sort((a, b) => b.time.compareTo(a.time));
  }

  void changeStartDate(DateTime date) {
    startDate.value = date;
    filterDonations();
  }

  void changeEndDate(DateTime date) {
    endDate.value = date;
    filterDonations();
  }
}
