import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/curr_user.dart';

import '../../../../models/CreatePostModel/admin_post_model.dart';

class DonationPostsUserController extends GetxController {
  var posts = <AdminPostModel>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    // isLoading(true);
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Posts')
          .where('postAccepted', isEqualTo: true)
          .get();

      final filteredPosts = snapshot.docs.where((doc) {
        final post = AdminPostModel.fromMap(doc.data());
        return post.donationRaised < post.donationNeeded &&
            post.userId != OneUser.currUserId;
      }).toList();

      posts.value = filteredPosts.map((doc) {
        final data = doc.data();
        return AdminPostModel.fromMap(data)..id = doc.id;
      }).toList();
    } catch (e) {
      // Handle error
      // print("Error fetching posts: $e");
    }
    // finally {
    //   isLoading(false);
    // }
  }
}
