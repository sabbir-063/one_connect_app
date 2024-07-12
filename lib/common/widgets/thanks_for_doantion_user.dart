import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../navigation_bar.dart';

class ThanksForDonationScreen extends StatelessWidget {
  const ThanksForDonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thank You!'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const RotatingCoin(),
              const SizedBox(height: 20),
              const Text(
                'Thank You for Your Donation!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Your support is greatly appreciated and will help those in need.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Get.offAll(() =>
                      const NavigationBarMenu()); // Navigate back to the homepage
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Go to Homepage',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RotatingCoin extends StatefulWidget {
  const RotatingCoin({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RotatingCoinState createState() => _RotatingCoinState();
}

class _RotatingCoinState extends State<RotatingCoin>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Image.asset(
        './assets/images/donation/coin.jpg',
        width: 100,
        height: 100,
      ),
      builder: (context, child) {
        return Transform(
          transform: Matrix4.rotationY(_controller.value * 2.0 * 3.1415927),
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }
}
