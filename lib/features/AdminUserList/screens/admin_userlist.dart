import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/utils/constants/colors.dart';
import '../../../models/UserModel/user_model.dart';
import '../controllers/admin_userlist.controller.dart';

class AdminUserlistScreen extends StatelessWidget {
  final AdminUserController controller = Get.put(AdminUserController());

  AdminUserlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: OneColors.accent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
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
                  hintText: 'Search by name or email',
                  hintStyle: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6.0),

            // User List with Scrollbar
            Expanded(
              child: Obx(() {
                if (controller.filteredUsers.isEmpty) {
                  return const Center(child: Text('No users found.'));
                }
                return Scrollbar(
                  thumbVisibility: true,
                  child: ListView.builder(
                    itemCount: controller.filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = controller.filteredUsers[index];
                      int rank = controller.users.indexOf(user) + 1;
                      return Container(
                        color: index % 2 == 0
                            ? Colors.blueGrey.shade50
                            : Colors.white,
                        child: ListTile(
                          leading: Text(
                            '$rank', // Rank
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            '${user.firstName} ${user.lastName}', // User name
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                          subtitle: Text(
                            'Donations Given: ${user.donationGiven} taka', // Donation given
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          onTap: () => _showUserDetails(context, user),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Popup for User Details
  void _showUserDetails(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Profile Picture
                CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(user.profileUrl.isEmpty
                      ? 'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI='
                      : user.profileUrl),
                  backgroundColor: Colors.grey.shade200,
                ),
                const SizedBox(height: 30),

                // User Info
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  'user_id : ${user.userNameAuto}',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  'Phone: ${user.phone}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  'Country: ${user.country}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  'State: ${user.state}, City: ${user.city}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Birthday: ${user.birthday}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Donation given: ${user.donationGiven} Taka',
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(135, 0, 165, 66),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                Text(
                  'Donation received: ${user.donationReceived} Taka',
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(137, 0, 176, 70),
                      fontWeight: FontWeight.bold),
                ),

                // Close button
                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
