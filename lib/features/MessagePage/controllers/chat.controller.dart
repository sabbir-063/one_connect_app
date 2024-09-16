import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/curr_user.dart';
import '../../../models/MessageModel/message_model.dart';
import '../../../models/UserModel/user_model.dart';

class UserChatController extends GetxController {
  var messages = <MessageModel>[].obs;
  var isLoading = true.obs;
  TextEditingController messageController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUserEmail();
  }

  Future<void> getUserEmail() async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(OneUser.currUserId).get();
      if (userDoc.exists) {
        UserModel user =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        userEmail.value = user.email;
        fetchMessages();
      } else {
        Get.snackbar('Error', 'User not found');
        isLoading.value = false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user details: $e');
      isLoading.value = false;
    }
  }

  void fetchMessages() {
    _firestore
        .collection('chats')
        .doc(userEmail.value)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isEmpty) {
        isLoading.value = false; // No messages found
      } else {
        messages.value = snapshot.docs.map((doc) {
          return MessageModel.fromMap(doc.data());
        }).toList();
        isLoading.value = false;
      }
    });
  }

  void sendMessage(String sender) {
    if (messageController.text.isNotEmpty) {
      _firestore
          .collection('chats')
          .doc(userEmail.value)
          .collection('messages')
          .add({
        'sender': sender,
        'content': messageController.text,
        'timestamp': DateTime.now(),
      });
      messageController.clear();
    }
  }
}
