import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostController extends GetxController {
  final textController = TextEditingController();
  final donationController = TextEditingController();
  final photos = <XFile>[].obs;

  bool get isFormValid =>
      textController.text.isNotEmpty &&
      donationController.text.isNotEmpty &&
      photos.isNotEmpty;
}
