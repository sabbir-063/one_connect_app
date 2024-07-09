import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/features/authentication/screens/login/login.dart';

class DonationOnboardingPage extends StatelessWidget {
  final List<Map<String, String>> featureList = [
    {
      'title': 'Seek Donation',
      'description':
          'Users can post requests for donations and receive support from the community.',
      'image':
          'assets/images/onboarding/img1.png' // Replace with your own image path
    },
    {
      'title': 'Central Fund',
      'description':
          'Users can contribute to our central fund to help those in need.',
      'image':
          'assets/images/onboarding/img2.png' // Replace with your own image path
    },
    {
      'title': 'Help the Poor',
      'description':
          'We donate to poor people from our central fund to provide them with essential support.',
      'image':
          'assets/images/onboarding/img3.jfif' // Replace with your own image path
    },
    {
      'title': 'Top Donators',
      'description':
          'Users can view the list of top donators and get inspired by their generosity.',
      'image':
          'assets/images/onboarding/img4.png' // Replace with your own image path
    },
  ];

  final List<String> quotes = [
    '“No one has ever become poor by giving.” – Anne Frank',
    '“It’s not how much we give but how much love we put into giving.” – Mother Teresa',
    '“For it is in giving that we receive.” – Francis of Assisi',
  ];

  DonationOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Our Donation Page'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ...featureList.map((feature) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        feature['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        feature['description']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                          feature['image']!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 250,
                        ),
                      ),
                      const Divider(height: 5),
                      const SizedBox(height: 50),
                    ],
                  ),
                )),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Famous Quotes on Giving',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ...quotes.map((quote) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          quote,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Footer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const LoginScreen());
        },
        tooltip: 'Go to Login',
        child: const Icon(Icons.login),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Join us in making a difference!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Together, we can help those in need and build a better community.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            '© 2024 Your Organization. All rights reserved.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
