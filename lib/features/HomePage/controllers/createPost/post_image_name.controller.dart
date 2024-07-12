import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../curr_user.dart';

class PostImageNameController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final profilePicUrl = ''.obs;
  final firstname = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfileInfo();
  }

  Future<void> fetchUserProfileInfo() async {
    try {
      final userId = OneUser.currUserId;
      final userDoc = await _firestore.collection('Users').doc(userId).get();

      if (userDoc.exists) {
        final data = userDoc.data();
        if (data != null) {
          firstname.value = data['firstName'];
          profilePicUrl.value = data['profileUrl'] ?? '';
        }
      }
    } catch (e) {
      print("Error fetching user profile: $e");
    }
  }

    void updateUserProfile() {
    fetchUserProfileInfo();
  }
  
}
