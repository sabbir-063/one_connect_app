import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../models/CreatePostModel/admin_post_model.dart';

class DonationPostsController extends GetxController {
  var posts = <AdminPostModel>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Posts')
          .where('postAccepted', isEqualTo: true)
          .get();

      final filteredPosts = snapshot.docs.where((doc) {
        final post = AdminPostModel.fromMap(doc.data());
        return post.donationRaised < post.donationNeeded;
      }).toList();

      posts.value = filteredPosts.map((doc) {
        final data = doc.data();
        return AdminPostModel.fromMap(data)..id = doc.id;
      }).toList();
    } catch (e) {
      // Handle error
      // print("Error fetching posts: $e");
    }
  }

  // void fetchPosts() {
  //   firestore
  //       .collection('Posts')
  //       .where('postAccepted', isEqualTo: true)
  //       .where('donationRaised',
  //           isLessThan: FieldValue.arrayUnion(['donationNeeded']))
  //       .snapshots()
  //       .listen((snapshot) {
  //     posts.value = snapshot.docs.map((doc) {
  //       var post = AdminPostModel.fromMap(doc.data());
  //       post.id = doc.id; // Assign document ID
  //       return post;
  //     }).toList();
  //   });
  // }

  // void donateToPost(String postId, int amount) {
  //   FirebaseFirestore.instance.collection('Posts').doc(postId).update({
  //     'donationRaised': FieldValue.increment(amount),
  //   });
  // }
}
