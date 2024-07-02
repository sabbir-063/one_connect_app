import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/MessageModel/message_model.dart';

class AdminChatController extends GetxController {
  var messages = <MessageModel>[].obs;
  TextEditingController messageController = TextEditingController();

  void sendMessage(String sender, String receiver) {
    if (messageController.text.isNotEmpty) {
      messages.insert(
        0,
        MessageModel(
          sender: sender,
          receiver: receiver,
          content: messageController.text,
          timestamp: DateTime.now(),
        ),
      );
      messageController.clear();
    }
  }
}
