// admin_userlist_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/UserModel/user_model.dart';
import '../controllers/admin_userlist.controller.dart';
import 'widgets/user_rank.dart';

class AdminUserlistScreen extends StatelessWidget {
  final AdminUserListController userController =
      Get.put(AdminUserListController());

  AdminUserlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildSearchBar(),
                const SizedBox(height: 16),
                _buildSortDropdowns(),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (userController.users.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: userController.users.length,
                  itemBuilder: (context, index) {
                    UserModel user = userController.users[index];
                    return _buildUserListItem(user, index);
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: (value) => userController.search(value),
      decoration: const InputDecoration(
        hintText: 'Search by name, email, or phone',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildSortDropdowns() {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Sort by',
            ),
            value: userController.sortBy,
            onChanged: (value) => userController.setSortBy(value!),
            items: const [
              DropdownMenuItem(value: 'name', child: Text('Name')),
              DropdownMenuItem(value: 'email', child: Text('Email')),
              DropdownMenuItem(value: 'phone', child: Text('Phone')),
              DropdownMenuItem(
                  value: 'donationGiven', child: Text('Donation Given')),
              DropdownMenuItem(
                  value: 'donationReceived', child: Text('Donation Received')),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DropdownButtonFormField<bool>(
            decoration: const InputDecoration(
              labelText: 'Order',
            ),
            value: userController.sortAscending,
            onChanged: (value) => userController.setSortAscending(value!),
            items: const [
              DropdownMenuItem(value: true, child: Text('Low to High')),
              DropdownMenuItem(value: false, child: Text('High to Low')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserListItem(UserModel user, int index) {
    UserRank rank = userController.getUserRank(index);
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          child: Text('${index + 1}'), // Show rank number as fallback
        ),
        title: Text('${user.firstName} ${user.lastName}'),
        subtitle: Text('Donation Given: ${user.donationGiven} Tk'),
        trailing: _buildRankIcon(rank),
      ),
    );
  }

  Widget _buildRankIcon(UserRank rank) {
    IconData iconData;
    Color color;
    switch (rank) {
      case UserRank.Gold:
        iconData = Icons.emoji_events;
        color = Colors.yellow;
        break;
      case UserRank.Silver:
        iconData = Icons.emoji_events;
        color = Colors.grey;
        break;
      case UserRank.Bronze:
        iconData = Icons.emoji_events;
        color = Colors.brown;
        break;
      default:
        return const SizedBox.shrink(); // No icon if rank not defined
    }
    return Icon(
      iconData,
      color: color,
    );
  }
}
















// // user_list_page.dart

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../models/UserModel/user_model.dart';

// import '../controllers/admin_userlist.controller.dart';
// import 'widgets/user_rank.dart';

// class AdminUserlistScreen extends StatelessWidget {
//   final AdminUserListController userController =
//       Get.put(AdminUserListController());

//   AdminUserlistScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User List'),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: _buildSearchBar(),
//           ),
//           Expanded(
//             child: Obx(() {
//               if (userController.users.isEmpty) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else {
//                 return ListView.builder(
//                   itemCount: userController.users.length,
//                   itemBuilder: (context, index) {
//                     UserModel user = userController.users[index];
//                     return _buildUserListItem(user, index);
//                   },
//                 );
//               }
//             }),
//           ),

//           ///
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return TextField(
//       onChanged: (value) => userController.search(value),
//       decoration: const InputDecoration(
//         hintText: 'Search by name, email, or phone',
//         prefixIcon: Icon(Icons.search),
//         border: OutlineInputBorder(),
//       ),
//     );
//   }

//   Widget _buildUserListItem(UserModel user, int index) {
//     UserRank rank = userController.getUserRank(index);
//     return Card(
//       margin: const EdgeInsets.all(8),
//       child: ListTile(
//         leading: CircleAvatar(
//           child: Text('${index + 1}'), // Show rank number as fallback
//         ),
//         title: Text('${user.firstName} ${user.lastName}'),
//         subtitle: Text('Donation Given: ${user.donationGiven} Tk'),
//         trailing: _buildRankIcon(rank),
//       ),
//     );
//   }

//   Widget _buildRankIcon(UserRank rank) {
//     IconData iconData;
//     Color color;
//     switch (rank) {
//       case UserRank.Gold:
//         iconData = Icons.emoji_events;
//         color = Colors.yellow;
//         break;
//       case UserRank.Silver:
//         iconData = Icons.emoji_events;
//         color = Colors.grey;
//         break;
//       case UserRank.Bronze:
//         iconData = Icons.emoji_events;
//         color = Colors.brown;
//         break;
//       default:
//         return const SizedBox.shrink(); // No icon if rank not defined
//     }
//     return Icon(
//       iconData,
//       color: color,
//     );
//   }
// }
