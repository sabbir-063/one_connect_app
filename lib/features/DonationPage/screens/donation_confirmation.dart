import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../navigation_bar.dart';

class DonationConfirmationPage extends StatelessWidget {

  const DonationConfirmationPage(
      {super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<NavigationController>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back or add functionality here
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Add the donation image
              Image.asset(
                'assets/images/donation/donate_3.png',
                // height: 100.0, // Set the height of the image
                fit: BoxFit.contain, // Adjust the fit as needed
              ),
              const Icon(
                Icons.check_circle,
                size: 80.0,
                color: Colors.green,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Thank You!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Thank you for your generous DONATION!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20.0),
              const Icon(
                Icons.thumb_up,
                size: 60.0,
                color: Colors.amber,
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  // Handle the done button press
                  Get.offAll(() => const NavigationBarMenu());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'DONE',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF4F4F4),
    );
  }
}
