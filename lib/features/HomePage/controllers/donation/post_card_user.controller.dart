import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../models/UserModel/user_model.dart';

class PostCardUserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var profilePicUrl = ''.obs;

  

  Future<String> getUserPhoneNumber(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(userId).get();
      if (userDoc.exists) {
        UserModel user =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        return user.phone;
      } else {
        Get.snackbar('Error', 'User not found');
        return '';
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user details: $e');
      return '';
    }
  }

  Future<String> getCentralPhoneNumber(String userID) async {
    try {
      // Access the document of the given userID in CentralFund collection
      DocumentSnapshot userDoc =
          await _firestore.collection('CentralFund').doc(userID).get();

      // Check if the document exists
      if (userDoc.exists) {
        // Extract the phonenumber field from the document
        String phoneNumber = userDoc['phoneNumber'];
        return phoneNumber;
      } else {
        print('CentralFund user not found');
        return 'null';
      }
    } catch (e) {
      // Handle error
      print('Error fetching user phone number: $e');
      return 'null';
    }
  }

  Future<String> getUserFullName(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(userId).get();
      if (userDoc.exists) {
        UserModel user =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        String nAME = '${user.firstName} ${user.lastName}';
        return nAME;
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
