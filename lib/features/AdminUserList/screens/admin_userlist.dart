import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/admin_userlist.controller.dart';

class AdminUserlistScreen extends StatelessWidget {
  final AdminUserController controller = Get.put(AdminUserController());

  AdminUserlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                onChanged: controller.search,
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
                if (controller.filteredUsers.isEmpty) {
                  return const Center(child: Text('No users found.'));
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
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
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Donations Given')),
                      DataColumn(label: Text('Donations Received')),
                      DataColumn(label: Text('Country')),
                      DataColumn(label: Text('City')),
                    ],
                    rows: controller.filteredUsers.map((user) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              (controller.users.indexOf(user) + 1).toString(),
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
                            Text(
                              user.email,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              user.donationGiven.toString(),
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              user.donationReceived.toString(),
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              user.country,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              user.city,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                        color: MaterialStateColor.resolveWith((states) {
                          if (controller.users.indexOf(user) % 2 == 0) {
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

            // Pagination Controls
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: controller.previousPage,
                  ),
                  Text(
                    'Page ${controller.currentPage.value}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: controller.nextPage,
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
