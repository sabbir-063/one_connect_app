import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/utils/constants/colors.dart';

import '../controllers/donation.controller.dart';

class DonationPageScreen extends StatelessWidget {
  DonationPageScreen({super.key});

  final List<String> imgList = [
    'assets/images/donation/donate_1.png',
    'assets/images/donation/donate_2.jfif',
    'assets/images/donation/donate_3.png',
  ];

  final DonationController controller = Get.put(DonationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Donate in Central Fund'),
        centerTitle: true,
        backgroundColor: OneColors.accent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Donation Text
            const Text(
              'Support People with Your Donation',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),

            // Carousel Slider with Images
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 700),
                viewportFraction: 0.8,
              ),
              items: imgList.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(item),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),

            // Donation Amount
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Enter Donation Amount',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: controller.amountController,
                    decoration: const InputDecoration(
                      labelText: 'Amount (Taka)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.money),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),

            // Donation Method
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Choose a Donation Method',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12.0),
                  Obx(() {
                    return DropdownButtonFormField<String>(
                      value: controller.selectedMethod.value,
                      onChanged: (value) {
                        if (value != null) {
                          controller.setSelectedMethod(value);
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Select Method',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.payment),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'Bkash', child: Text('Bkash')),
                        DropdownMenuItem(value: 'Nogod', child: Text('Nogod')),
                        DropdownMenuItem(
                            value: 'Rocket', child: Text('Rocket')),
                        DropdownMenuItem(
                            value: 'Online Banking',
                            child: Text('Online Banking')),
                      ],
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 16.0),

            // Donate Button
            ElevatedButton(
              onPressed: () {
                controller.handleDonation();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                'Donate',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
