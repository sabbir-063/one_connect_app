import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/CreatePostModel/admin_post_model.dart';

class AdminHomeController extends GetxController {
  var posts = <AdminPostModel>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchPendingPosts();
  }

  void fetchPendingPosts() {
    firestore
        .collection('Posts')
        .where('adminChecked', isEqualTo: false)
        .snapshots()
        .listen((snapshot) {
      posts.value = snapshot.docs.map((doc) {
        var post = AdminPostModel.fromMap(doc.data());
        post.id = doc.id; // Assign document ID
        return post;
      }).toList();
    });
  }

  void acceptPost(String postId) async {
    await firestore.collection('Posts').doc(postId).update({
      'postAccepted': true,
      'adminChecked': true,
    });
  }

  void rejectPost(String postId) async {
    await firestore.collection('Posts').doc(postId).update({
      'postAccepted': false,
      'adminChecked': true,
    });
  }
}
