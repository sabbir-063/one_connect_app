import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/admin_received_fund.controller.dart';

class AdminReceivedFundpage extends StatelessWidget {
  AdminReceivedFundpage({super.key});

  final AdminReceivedFundController controller =
      Get.put(AdminReceivedFundController());

  @override
  Widget build(BuildContext context) {
    controller.fetchData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Received Fund'),
        centerTitle: true,
      ),
      body: Obx(() {
        // Check if loading
        if (controller.isLoading.value == true) {
          // Display a CircularProgressIndicator in the center of the screen
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Date range selection buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: controller.startDate.value,
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            controller.changeStartDate(pickedDate);
                          }
                        },
                        child: Text(
                          'Start Date: ${DateFormat.yMMMd().format(controller.startDate.value)}',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: controller.endDate.value,
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            controller.changeEndDate(pickedDate);
                          }
                        },
                        child: Text(
                          'End Date: ${DateFormat.yMMMd().format(controller.endDate.value)}',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Donation list
                Expanded(
                  child: Obx(() {
                    if (controller.filteredDonations.isEmpty) {
                      return const Center(
                        child: Text(
                          'No donations found in the selected date range.',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: controller.filteredDonations.length,
                        itemBuilder: (context, index) {
                          var donation = controller.filteredDonations[index];
                          var receiverName = controller
                              .getReceiverFullName(donation.donatorId);
                          return Card(
                            elevation: 4.0,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(receiverName.isNotEmpty
                                    ? receiverName[0]
                                    : '?'),
                              ),
                              title: Text(
                                '$receiverName - ${donation.donationMedia}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Align text to start
                                children: [
                                  Text(
                                    'Amount: ${donation.amount.toStringAsFixed(2)} Taka',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.blueAccent),
                                  ),
                                  const SizedBox(
                                      height:
                                          4), // Add some spacing between lines
                                  Text(
                                    controller.fundType[donation.id] ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: controller.fundType[donation.id] ==
                                              'Special Fund'
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                  DateFormat.yMMMd().format(donation.time)),
                            ),
                          );
                        },
                      );
                    }
                  }),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
