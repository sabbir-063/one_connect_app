import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/CreatePostModel/admin_post_model.dart';
import '../../../models/UserModel/user_model.dart';
import '../../../models/notificationModel/notification_model.dart';
import '../../AdminPostPage/controllers/donation_posts.controller.dart';

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
    final controller = Get.find<DonationPostsController>();
    controller.updatePostPage();
    aceptedPostInfo(postId);
  }

  void rejectPost(String postId) async {
    await firestore.collection('Posts').doc(postId).update({
      'postAccepted': false,
      'adminChecked': true,
    });
    rejectedPostInfo(postId);
  }

  Future<String> getUserFullName(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await firestore.collection('Users').doc(userId).get();
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

  Future<void> aceptedPostInfo(String postId) async {
    try {
      DocumentSnapshot postDoc =
          await firestore.collection('Posts').doc(postId).get();
      if (postDoc.exists) {
        AdminPostModel post =
            AdminPostModel.fromMap(postDoc.data() as Map<String, dynamic>);
        NotificationModel notification1 = NotificationModel(
          message:
              'Your recent post has been approved by the admin, in which you requested a donation of ${post.donationNeeded} Taka.',
          title: 'Post approved',
          timeStamp: DateTime.now(),
        );

        String email = await getUserEmail(post.userId);
        //add notification
        await firestore
            .collection('Notifications')
            .doc(email)
            .collection('UserNotifications')
            .add(notification1.toMap());
      } else {
        // Get.snackbar('Error', 'User not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch post details: $e');
    }
  }

  Future<void> rejectedPostInfo(String postId) async {
    try {
      DocumentSnapshot postDoc =
          await firestore.collection('Posts').doc(postId).get();
      if (postDoc.exists) {
        AdminPostModel post =
            AdminPostModel.fromMap(postDoc.data() as Map<String, dynamic>);
        NotificationModel notification1 = NotificationModel(
          message:
              'Your recent post has been rejected by admin because admin cant verify your post information in which you needed ${post.donationNeeded} Taka donation.',
          title: 'Post rejected',
          timeStamp: DateTime.now(),
        );

        String email = await getUserEmail(post.userId);
        //add notification
        await firestore
            .collection('Notifications')
            .doc(email)
            .collection('UserNotifications')
            .add(notification1.toMap());
      } else {
        // Get.snackbar('Error', 'User not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch post details: $e');
    }
  }

  Future<String> getUserEmail(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await firestore.collection('Users').doc(userId).get();
      if (userDoc.exists) {
        UserModel user =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        return user.email;
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
