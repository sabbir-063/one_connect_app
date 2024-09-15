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

  // Loading states for posts
  var isLoadingRegularPosts = true.obs;
  var isLoadingDonationPosts = true.obs;

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
    // Regular post fetching
    isLoadingRegularPosts.value = true;
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('AdminRegularPosts')
          .get();

      final filterPosts = snapshot.docs.toList();
      filteredPostsRegular.value = filterPosts.map((doc) {
        final data = doc.data();
        return AdminPostModel.fromMap(data)..id = doc.id;
      }).toList();
    } catch (e) {
      print("Error fetching regular posts: $e");
    } finally {
      isLoadingRegularPosts.value = false; // Regular posts loading finished
    }

    // Donation posts fetching
    isLoadingDonationPosts.value = true;
    try {
      final snapshot2 =
          await FirebaseFirestore.instance.collection('AdminPosts').get();

      final filterPosts2 = snapshot2.docs.toList();
      filteredPostsDonation.value = filterPosts2.map((doc) {
        final data = doc.data();
        return AdminPostModel.fromMap(data)..id = doc.id;
      }).toList();
    } catch (e) {
      print("Error fetching donation posts: $e");
    } finally {
      isLoadingDonationPosts.value = false; // Donation posts loading finished
    }
  }
}
