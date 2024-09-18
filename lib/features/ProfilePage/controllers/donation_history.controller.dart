import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/curr_user.dart';
import 'package:one_connect_app/models/DonationModel/donation_tracker.dart';

class DonationHistoryController extends GetxController {
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
          .where('donatorId', isEqualTo: OneUser.currUserId)
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
    }
  }

  Future<void> _fetchReceiverNames() async {
    final firestore = FirebaseFirestore.instance;

    for (var donation in donations) {
      // if (!receiverNames.containsKey(donation.receiverId)) {
      try {
        final userDoc =
            await firestore.collection('Users').doc(donation.receiverId).get();
        if (userDoc.exists) {
          String firstName = userDoc.data()?['firstName'] ?? '';
          String lastName = userDoc.data()?['lastName'] ?? '';
          receiverNames[donation.id] = '$firstName $lastName';
        } else {
          if (donation.postId != '0') {
            receiverNames[donation.id] = 'Special Fund';
            // print('Dorker Ase');
          } else {
            receiverNames[donation.id] = 'Central Fund Regular';
            // print('Dorker Nai');
          }
        }
      } catch (e) {
        receiverNames[donation.id] = 'Error retrieving user name';
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
