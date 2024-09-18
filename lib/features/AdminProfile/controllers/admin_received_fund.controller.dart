import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../curr_user.dart';
import '../../../models/DonationModel/donation_tracker.dart';

class AdminReceivedFundController extends GetxController {
  var donations = <DonationTracker>[].obs;
  var filteredDonations = <DonationTracker>[].obs;
  var startDate = DateTime.now().subtract(const Duration(days: 30)).obs;
  var endDate = DateTime.now().obs;

  var isLoading = true.obs;
  // Map to store the receiver's full name
  var receiverNames = <String, String>{}.obs;
  var fundType = <String, String>{}.obs;

  void init() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    final firestore = FirebaseFirestore.instance;
    isLoading.value = true;
    try {
      final snapshot = await firestore
          .collection('DonationTracker')
          .where('receiverId', isEqualTo: OneUser.centralFundId)
          .get();

      final fetchedDonations = snapshot.docs.where((doc) {
        return true;
      }).toList();

      donations.value = fetchedDonations.map((doc) {
        return DonationTracker.fromMap(doc.data())..id = doc.id;
      }).toList();

      await _fetchReceiverNames();
      filterDonations();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch donation history: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchReceiverNames() async {
    final firestore = FirebaseFirestore.instance;

    for (var donation in donations) {
      // if (!receiverNames.containsKey(donation.donatorId)) {
      try {
        if (donation.postId == '0') {
          fundType[donation.id] = 'Central Fund';
        } else {
          fundType[donation.id] = 'Special Fund';
        }

        final userDoc =
            await firestore.collection('Users').doc(donation.donatorId).get();
        if (userDoc.exists) {
          String firstName = userDoc.data()?['firstName'] ?? '';
          String lastName = userDoc.data()?['lastName'] ?? '';
          receiverNames[donation.donatorId] = '$firstName $lastName';

          print(receiverNames[donation.donatorId]);
        } else {
          receiverNames[donation.donatorId] = 'User not found';
        }
      } catch (e) {
        receiverNames[donation.donatorId] = 'Error retrieving user name';
      }
      // }
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
