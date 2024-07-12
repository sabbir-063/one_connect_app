import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../models/UserModel/admin_model.dart';

class AdminController extends GetxController {
  final Rx<AdminModel> loggedUser = AdminModel(
    name: '',
    email: '',
    password: '',
  ).obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchAdminData(String adminId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('Admins').doc(adminId).get();
      if (userDoc.exists) {
        loggedUser.value =
            AdminModel.fromMap(userDoc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching Admin data: $e");
    }
  }
}
