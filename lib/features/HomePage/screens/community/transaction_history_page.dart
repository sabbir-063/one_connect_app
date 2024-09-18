import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:one_connect_app/models/UserModel/user_model.dart';

import '../../../../models/DonationModel/donation_tracker.dart';

class TransactionHistoryPage extends StatelessWidget {
  final String postID;

  TransactionHistoryPage({super.key, required this.postID});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DonationTracker>> fetchDonations() async {
    final snapshot = await _firestore
        .collection('DonationTracker')
        .where('postId', isEqualTo: postID)
        .get();

    print(postID);

    return snapshot.docs.map((doc) {
      return DonationTracker.fromMap(doc.data())..id = doc.id;
    }).toList();
  }

  Future<String> getUserFullName(String userId) async {
    try {
      final userDoc = await _firestore.collection('Users').doc(userId).get();
      if (userDoc.exists) {
        UserModel user =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        return '${user.firstName} ${user.lastName}';
      } else {
        return 'OneConnect Admin';
      }
    } catch (e) {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        centerTitle: true,
        backgroundColor: Colors.teal, // Customize as per your app theme
      ),
      body: FutureBuilder<List<DonationTracker>>(
        future: fetchDonations(), // Replace with your donation fetch method
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No transactions found.'));
          } else {
            final donations = snapshot.data!;
            return ListView.builder(
              itemCount: donations.length,
              padding: const EdgeInsets.all(8.0), // Padding for scroll area
              itemBuilder: (context, index) {
                final donation = donations[index];

                // Adding a Card for each donation
                return FutureBuilder<String>(
                  future: donation.isAnonymus
                      ? Future.value(donation.donatorId)
                      : getUserFullName(
                          donation.donatorId), // Fetching user's full name
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
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
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10), // Space between cards
                        elevation: 5, // Shadow effect
                        child: Padding(
                          padding: const EdgeInsets.all(
                              16.0), // Padding inside the card
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
                              const SizedBox(
                                  height: 8), // Spacing between elements
                              Text(
                                'Amount: ${donation.amount} Tk',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(
                                  height: 4), // Spacing between elements
                              Text(
                                'Media: ${donation.donationMedia}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(
                                  height: 4), // Spacing between elements
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
        },
      ),
    );
  }
}
