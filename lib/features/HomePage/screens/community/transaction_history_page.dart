import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:one_connect_app/models/UserModel/user_model.dart';
import 'package:one_connect_app/utils/constants/colors.dart';

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
        backgroundColor: OneColors.accent,
      ),
      body: FutureBuilder<List<DonationTracker>>(
        future: fetchDonations(),
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
              itemBuilder: (context, index) {
                final donation = donations[index];

                return FutureBuilder<String>(
                  future: donation.isAnonymus
                      ? Future.value(donation.donatorId)
                      : getUserFullName(donation.donatorId),
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
                      return ListTile(
                        title: Text(userSnapshot.data ?? 'Unknown User'),
                        subtitle: Text(
                          'Amount: ${donation.amount} Tk\nMedia: ${donation.donationMedia}\nTime: ${donation.time}',
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
