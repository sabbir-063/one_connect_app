import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../admin_navigation_bar.dart';

class AdminPostConfirmationPage extends StatelessWidget {
  const AdminPostConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline_rounded,
              size: 100,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            const Text(
              'Your post is submitted',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            // const SizedBox(height: 10),
            // const Text(
            //   'Admin will review your post, contact you for verification, and approve it for the community feed.',
            //   style: TextStyle(fontSize: 16),
            //   textAlign: TextAlign.center,
            // ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.offAll(() => const AdminNavigationBarMenu());
                },
                child: const Text('Go back to homepage'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
