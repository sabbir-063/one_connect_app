import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OneHelperFunctions {
  static Future<bool> isProfilePicEmpty(String userId) async {
    try {
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get the user's document from the 'Users' collection
      DocumentSnapshot userDoc =
          await firestore.collection('Users').doc(userId).get();

      if (userDoc.exists) {
        // Check if the 'profilePic' field exists and is not empty
        String profilePic = userDoc['profileUrl'];
        if (profilePic.isNotEmpty) {
          return false; // profilePic is not empty
        }
      }
      return true; // profilePic is empty or doesn't exist
    } catch (e) {
      // Handle any errors that occur during the Firestore request
      print('Error checking profile picture: $e');
      return true; // In case of an error, assume profilePic is empty
    }
  }

  static Future<String> getProfilePicUrl(String userId) async {
    final FirebaseStorage storage = FirebaseStorage.instance;

    try {
      String filePath = 'profile_pictures/$userId/picture.png';
      String downloadUrl = await storage.ref(filePath).getDownloadURL();
      print(downloadUrl);
      return downloadUrl;
    } catch (e) {
      return '';
    }
  }

  static Color? getColor(String value) {
    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Perple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else {
      return Colors.amber;
    }
  }

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static void showCustomSnackBar(String title, String message, bool isSuccess) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      barBlur: 0,
      animationDuration: const Duration(milliseconds: 300),
      forwardAnimationCurve: Curves.easeOut,
      reverseAnimationCurve: Curves.easeIn,
      mainButton: TextButton(
        onPressed: () {
          Get.back(); // Close the snackbar
        },
        child: const Text(
          'Dismiss',
          style: TextStyle(color: Colors.white),
        ),
      ),
      isDismissible: true,
      showProgressIndicator: true,
      progressIndicatorValueColor:
          const AlwaysStoppedAnimation<Color>(Colors.white),
      progressIndicatorBackgroundColor: Colors.grey,
    );
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static List<T> removeDuplicate<T>(List<T> list) {
    return list.toSet().toList();
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM YYYY'}) {
    return DateFormat(format).format(date);
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];

    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }

    return wrappedList;
  }
}
