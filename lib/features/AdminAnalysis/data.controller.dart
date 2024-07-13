import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../models/CreatePostModel/admin_post_model.dart';
import '../../models/UserModel/user_model.dart';

class DataController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var users = <UserModel>[].obs;
  var posts = <AdminPostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    fetchPosts();
  }

  Future<void> fetchUsers() async {
    try {
      final userDocs = await _firestore.collection('Users').get();
      users.value = userDocs.docs
          .map((doc) => UserModel(
                firstName: doc['firstName'],
                lastName: doc['lastName'],
                email: doc['email'],
                phone: doc['phone'],
                country: doc['country'],
                state: doc['state'],
                city: doc['city'],
                birthday: doc['birthday'],
                password: doc['password'],
                donationGiven: doc['donationGiven'],
                donationReceived: doc['donationReceived'],
                profileUrl: doc['profileUrl'],
              ))
          .toList();
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  Future<void> fetchPosts() async {
    try {
      final postDocs = await _firestore.collection('Posts').get();
      posts.value = postDocs.docs
          .map((doc) => AdminPostModel(
                id: doc.id,
                userId: doc['userId'],
                profileName: doc['profileName'],
                profilePicUrl: doc['profilePicUrl'],
                timeAgo: doc['timeAgo'],
                postMessage: doc['postMessage'],
                donationNeeded: doc['donationNeeded'],
                donationRaised: doc['donationRaised'],
                imageUrls: List<String>.from(doc['imageUrls']),
                postAccepted: doc['postAccepted'],
                adminChecked: doc['adminChecked'],
              ))
          .toList();
    } catch (e) {
      print("Error fetching posts: $e");
    }
  }
}
