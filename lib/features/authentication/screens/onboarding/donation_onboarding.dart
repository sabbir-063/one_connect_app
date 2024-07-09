import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/features/authentication/screens/login/login.dart';

class DonationOnboardingPage extends StatelessWidget {
  final List<String> imageList = [
    'assets/images/slider1.png', // Replace with your own images
    'assets/images/slider2.jpg',
    'assets/images/slider3.jpg',
    'assets/images/slider4.jpg',
  ];

  final List<Map<String, String>> featureList = [
    {
      'title': 'Seek Donation',
      'description':
          'Users can post requests for donations and receive support from the community.'
    },
    {
      'title': 'Central Fund',
      'description':
          'Users can contribute to our central fund to help those in need.'
    },
    {
      'title': 'Help the Poor',
      'description':
          'We donate to poor people from our central fund to provide them with essential support.'
    },
    {
      'title': 'Top Donators',
      'description':
          'Users can view the list of top donators and get inspired by their generosity.'
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
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: const Duration(seconds: 3),
              ),
              items: imageList.map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ...featureList.map((feature) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feature['title']!,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        feature['description']!,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Divider(),
                    ],
                  ),
                )),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Famous Quotes on Giving',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...quotes.map((quote) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          quote,
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
          Text(
            'Join us in making a difference!',
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
