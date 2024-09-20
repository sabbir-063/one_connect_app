import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/models/DonationModel/donation_tracker.dart';
import 'package:one_connect_app/models/UserModel/user_model.dart';

class TransactionController extends GetxController {
  final String postID;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TransactionController(this.postID);

  // Fetch donations for a specific postID
  Future<List<DonationTracker>> fetchDonations() async {
    try {
      final snapshot = await _firestore
          .collection('DonationTracker')
          .where('postId', isEqualTo: postID)
          .get();

      return snapshot.docs.map((doc) {
        return DonationTracker.fromMap(doc.data())..id = doc.id;
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch donations: $e");
    }
  }

  // Get user's full name based on userId
  Future<String> getUserFullName(String userId) async {
    try {
      final userDoc = await _firestore.collection('Users').doc(userId).get();
      if (userDoc.exists) {
        UserModel user =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        return '${user.firstName} ${user.lastName}';
      } else {
        return 'OneConnect Admin';
      }
    } catch (e) {
      return 'Error';
    }
  }
}
