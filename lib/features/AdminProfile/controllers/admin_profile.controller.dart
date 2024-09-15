import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../curr_user.dart';
import '../../../models/CreatePostModel/admin_post_model.dart';
import '../../../models/UserModel/admin_model.dart';
import '../../AdminAnalysis/data.controller.dart';

class AdminController extends GetxController {
  final Rx<AdminModel> loggedUser = AdminModel(
    name: '',
    email: '',
    password: '',
  ).obs;

  Rx<int> donationGiven = 0.obs;
  Rx<int> fundRaised = 0.obs;
  Rx<int> totalRemainingCapital = 0.obs;
  Rx<int> specialFundRaised = 0.obs;
  var currUser = OneUser.centralFundId;
  final DataController dataController = Get.put(DataController());
  var isLoadingCharts = true.obs;
  var filteredPostsRegular = <AdminPostModel>[].obs;
  var filteredPostsDonation = <AdminPostModel>[].obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchAdminData(OneUser.currAdminId);
    fetchAdminAllPosts();
  }

  Future<void> fetchAdminData(String adminId) async {
    try {
      DocumentSnapshot userDoc =
          await firestore.collection('Admins').doc(adminId).get();
      if (userDoc.exists) {
        loggedUser.value =
            AdminModel.fromMap(userDoc.data() as Map<String, dynamic>);
      }
      updateAdminValue();
      isLoadingCharts.value = false;
    } catch (e) {
      // print("Error fetching Admin data: $e");
    }
  }

  Future<void> updateAdminValue() async {
    try {
      final currentUserDoc = firestore.collection('CentralFund').doc(currUser);
      final currentUserSnapshot = await currentUserDoc.get();

      if (currentUserSnapshot.exists) {
        int currValue =
            currentUserSnapshot.data()?['totalRemainingCapital'] ?? 0;
        int currValue2 = currentUserSnapshot.data()?['donationGiven'] ?? 0;
        int currValue3 = currentUserSnapshot.data()?['fundRaised'] ?? 0;
        int currValue4 = currentUserSnapshot.data()?['specialFundRaised'] ?? 0;

        totalRemainingCapital.value = currValue;
        donationGiven.value = currValue2;
        fundRaised.value = currValue3;
        specialFundRaised.value = currValue4;
      }
    } catch (e) {
      print('Hello error ${e}');
    }
  }

  Future<void> fetchAdminAllPosts() async {
    //regular post fetching
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('AdminRegularPosts')
          .get();

      //debug
      print('regular post asce firbase theke');

      final filterPosts = snapshot.docs.where((doc) {
        final post = AdminPostModel.fromMap(doc.data());
        return post.userId != OneUser.currUserId;
      }).toList();

      filteredPostsRegular.value = filterPosts.map((doc) {
        final data = doc.data();
        return AdminPostModel.fromMap(data)..id = doc.id;
      }).toList();

      //debug
      print('regular post filtered a store hoise. size ${filterPosts.length}');
    } catch (e) {
      // Handle error
      print("Error fetching posts: $e");
    }

    //donation posts fetching
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('AdminPosts').get();

      //debug
      print('admin donation post asce firbase theke');

      final filterPosts = snapshot.docs.where((doc) {
        final post = AdminPostModel.fromMap(doc.data());
        return post.donationRaised < post.donationNeeded &&
            post.userId != OneUser.currUserId;
      }).toList();

      filteredPostsDonation.value = filterPosts.map((doc) {
        final data = doc.data();
        return AdminPostModel.fromMap(data)..id = doc.id;
      }).toList();

      //debug
      print(
          'admin donation post filtered a store hoise. size ${filterPosts.length}');
    } catch (e) {
      // Handle error
      print("Error fetching posts: $e");
    }
  }
}
