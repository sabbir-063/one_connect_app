import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/donation/donatenow.controller.dart';

class DonateNowButtonScreen extends StatelessWidget {
  const DonateNowButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DonateNowController controller = Get.put(DonateNowController());

    // Retrieve arguments passed from the DonationPostCard
    final arguments = Get.arguments;
    controller.donationNeeded.value = arguments['donationNeeded'];
    controller.donationRaised.value = arguments['donationRaised'];
    controller.phoneNumber.value = arguments['phoneNumber'];
    controller.userId.value = arguments['userId'];
    controller.postId.value = arguments['postId'];
    int maxAmount =
        controller.donationNeeded.value - controller.donationRaised.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate Now'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('./assets/images/donation/donate_1.png'),
              const SizedBox(height: 10),
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
                      decoration: InputDecoration(
                        labelText: '(1 - ${maxAmount.toInt()}) Taka',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.money),
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
                    Obx(
                      () => DropdownButtonFormField<String>(
                        value: controller.selectedMethod.value,
                        onChanged: controller.updateSelectedMethod,
                        decoration: const InputDecoration(
                          labelText: 'Select Method',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.payment),
                        ),
                        items: const [
                          DropdownMenuItem(
                              value: 'Bkash', child: Text('Bkash')),
                          DropdownMenuItem(
                              value: 'Nogod', child: Text('Nogod')),
                          DropdownMenuItem(
                              value: 'Rocket', child: Text('Rocket')),
                          DropdownMenuItem(
                              value: 'Online Banking',
                              child: Text('Online Banking')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Anonymous Donation Checkbox
              Obx(
                () => CheckboxListTile(
                  title: const Text('Donate Anonymously'),
                  value: controller.isAnonymously.value,
                  onChanged: (bool? value) {
                    controller.isAnonymously.value = value ?? false;
                  },
                ),
              ),

              const SizedBox(height: 16.0),

              // Donate Button
              ElevatedButton(
                onPressed: () {
                  controller.validateDonationAmount();
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
      ),
    );
  }
}
