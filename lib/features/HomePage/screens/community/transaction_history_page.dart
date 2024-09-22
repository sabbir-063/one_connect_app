import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/utils/constants/colors.dart';
import '../../controllers/donation/transaction.controller.dart';

class TransactionHistoryPage extends StatelessWidget {
  final String postID;

  const TransactionHistoryPage({super.key, required this.postID});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final TransactionController controller =
        Get.put(TransactionController(postID));

    // Fetch donations when page loads
    controller.fetchDonations();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        centerTitle: true,
        backgroundColor: OneColors.accent,
      ),
      body: Obx(() {
        // Show loading indicator while fetching data
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.donations.isEmpty) {
          // Show a message when no transactions are found
          return const Center(child: Text('No transactions found.'));
        } else {
          // Build the transaction list
          return ListView.builder(
            itemCount: controller.donations.length,
            padding: const EdgeInsets.all(8.0), // Padding for scroll area
            itemBuilder: (context, index) {
              final donation = controller.donations[index];

              return FutureBuilder<String>(
                future: donation.isAnonymus
                    ? controller.getUserUserID(donation.donatorId)
                    : controller.getUserFullName(donation.donatorId),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const ListTile(
                      title: Text('Loading...'),
                    );
                  } else if (userSnapshot.hasError) {
                    return const ListTile(
                      title: Text('Error'),
                      subtitle: Text('Failed to fetch user name'),
                    );
                  } else {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 10,
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userSnapshot.data ?? 'Unknown User',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Amount: ${donation.amount} Tk',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Media: ${donation.donationMedia}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Time: ${donation.time}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            },
          );
        }
      }),
    );
  }
}
