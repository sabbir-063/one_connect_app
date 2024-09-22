import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/colors.dart';
import '../controllers/donator_list.controller.dart';

class DonatorListScreen extends StatelessWidget {
  final DonatorListController userController = Get.put(DonatorListController());

  DonatorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Donator List'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: OneColors.accent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                onChanged: userController.search,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Search by name, email, country, or city',
                  hintStyle: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // User List
            Expanded(
              child: Obx(() {
                if (userController.filteredUsers.isEmpty) {
                  return const Center(child: Text('No users found.'));
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columnSpacing: 20.0,
                    headingRowColor: WidgetStateColor.resolveWith(
                        (states) => Colors.blueGrey.shade100),
                    headingTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    columns: const [
                      DataColumn(label: Text('Rank')),
                      DataColumn(label: Text('User Name')),
                      DataColumn(label: Text('Badge')),
                    ],
                    rows: userController.filteredUsers.map((user) {
                      int rank = userController.users.indexOf(user) + 1;
                      String badge = _getBadge(rank);
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              (userController.users.indexOf(user) + 1)
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              '${user.firstName} ${user.lastName}',
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          DataCell(
                            badge.isNotEmpty
                                ? _buildBadge(badge)
                                : const SizedBox
                                    .shrink(), // Display badge or empty SizedBox
                          ),
                        ],
                        color: WidgetStateColor.resolveWith((states) {
                          if (userController.users.indexOf(user) % 2 == 0) {
                            return Colors.blueGrey.shade50;
                          } else {
                            return Colors.white;
                          }
                        }),
                      );
                    }).toList(),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to determine badge based on rank
  String _getBadge(int rank) {
    if (rank <= 2) {
      return 'Gold';
    } else if (rank <= 5) {
      return 'Silver';
    } else if (rank <= 8) {
      return 'Bronze';
    }
    return 'Newbie'; // No badge for other ranks
  }

  // Helper function to build badge widget
  Widget _buildBadge(String badge) {
    Color badgeColor = Colors.yellow; // Default badge color

    if (badge == 'Silver') {
      badgeColor = Colors.grey;
    } else if (badge == 'Bronze') {
      badgeColor = Colors.orange;
    } else if (badge == 'Newbie') {
      badgeColor = Colors.greenAccent;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        badge,
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
