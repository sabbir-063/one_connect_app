import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/models/DonationModel/donation_tracker.dart';
import 'package:one_connect_app/models/UserModel/user_model.dart';

class TransactionController extends GetxController {
  final String postID;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable list of donations
  var donations = <DonationTracker>[].obs;
  // Observable loading state
  var isLoading = false.obs;

  TransactionController(this.postID);

  // Fetch donations and update controller's donation list
  Future<void> fetchDonations() async {
    try {
      isLoading.value = true;
      final snapshot = await _firestore
          .collection('DonationTracker')
          .where('postId', isEqualTo: postID)
          .get();

      // Map snapshot to DonationTracker objects and update the donations list
      donations.value = snapshot.docs.map((doc) {
        return DonationTracker.fromMap(doc.data())..id = doc.id;
      }).toList();

      donations.sort((a, b) => b.time.compareTo(a.time));
    } catch (e) {
      print("Failed to fetch donations: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Get user's full name based on userId
  Future<String> getUserFullName(String userId) async {
    try {
      final userDoc = await _firestore.collection('Users').doc(userId).get();
      final userDoc2 = await _firestore.collection('Admins').doc(userId).get();
      print('user id : ${userId}');
      if (userDoc.exists) {
        UserModel user =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        return '${user.firstName} ${user.lastName}';
      } else if (userDoc2.exists) {
        return 'OneConnect Admin';
      } else {
        return 'User Name not found';
      }
    } catch (e) {
      return 'Error';
    }
  }

  // Get user's User ID based on userId
  Future<String> getUserUserID(String userId) async {
    try {
      final userDoc = await _firestore.collection('Users').doc(userId).get();
      if (userDoc.exists) {
        UserModel user =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        return user.userNameAuto;
      } else {
        return 'OneConnect Admin';
      }
    } catch (e) {
      return 'Error';
    }
  }
}
