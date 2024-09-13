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
        title: const Text('Admin Donation History'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
              return Row(
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
              );
            }),
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
                      var receiverName =
                          controller.getReceiverFullName(donation.receiverId);
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
                          title:
                              Text('$receiverName - ${donation.donationMedia}'),
                          subtitle: Text(
                              'Amount: ${donation.amount.toStringAsFixed(2)} Taka'),
                          trailing:
                              Text(DateFormat.yMMMd().format(donation.time)),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
