import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/curr_user.dart';

import '../../../../models/CreatePostModel/admin_post_model.dart';

class DonationPostsUserController extends GetxController {
  // var posts = <AdminPostModel>[].obs;
  var filteredPosts = <AdminPostModel>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var selectedCategoryIndex = 0.obs; // Track the selected category
  // var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    // isLoading(true);
    try {
      print('load hoise home page');
      filterPostsByCategory(0);
    } catch (e) {
      // Handle error
      print("Error fetching posts: $e");
    }
  }

  void changeCategory(int index) {
    selectedCategoryIndex.value = index;
    filterPostsByCategory(index);
  }

  Future<void> filterPostsByCategory(int categoryIndex) async {
    print('${categoryIndex} is selected');

    if (categoryIndex == 0) {
      // Filter for User Posts
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('Posts')
            .where('postAccepted', isEqualTo: true)
            .get();

        //debug
        print('normal post asce firbase theke');

        final filterPosts = snapshot.docs.where((doc) {
          final post = AdminPostModel.fromMap(doc.data());
          return post.donationRaised < post.donationNeeded &&
              post.userId != OneUser.currUserId;
        }).toList();

        //setting filteredpost
        filteredPosts.value = filterPosts.map((doc) {
          final data = doc.data();
          return AdminPostModel.fromMap(data)..id = doc.id;
        }).toList();

        //debug
        print('normal post filtered a store hoise. size ${filterPosts.length}');
      } catch (e) {
        // Handle error
        print("Error fetching posts: $e");
      }
    } else if (categoryIndex == 1) {
      // Filter for Admin Regular Posts
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

        filteredPosts.value = filterPosts.map((doc) {
          final data = doc.data();
          return AdminPostModel.fromMap(data)..id = doc.id;
        }).toList();

        //debug
        print(
            'regular post filtered a store hoise. size ${filterPosts.length}');
      } catch (e) {
        // Handle error
        print("Error fetching posts: $e");
      }
    } else if (categoryIndex == 2) {
      // Filter for Admin Donation Posts
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

        filteredPosts.value = filterPosts.map((doc) {
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
}
