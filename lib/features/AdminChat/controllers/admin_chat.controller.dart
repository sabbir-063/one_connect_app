import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/MessageModel/message_model.dart';

class AdminChatController extends GetxController {
  var messages = <MessageModel>[].obs;
  var isLoading = true.obs;
  TextEditingController messageController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String userEmail;

  @override
  void onInit() {
    super.onInit();
  }

  void initialize(String email) {
    userEmail = email;
    fetchMessages();
  }

  void fetchMessages() {
    _firestore
        .collection('chats')
        .doc(userEmail)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isEmpty) {
        isLoading.value = false;
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
      _firestore.collection('chats').doc(userEmail).collection('messages').add({
        'sender': sender,
        'content': messageController.text,
        'timestamp': DateTime.now(),
      });
      messageController.clear();
    }
  }
}
