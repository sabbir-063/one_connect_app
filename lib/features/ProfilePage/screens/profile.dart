import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/features/authentication/screens/login/login.dart';

import '../../../data/static_data/post_data/post_card_data.dart';
import '../../../models/UserModel/user_model.dart';
import '../../HomePage/screens/community/donation_post_card.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final UserModel user = UserModel(
    firstName: 'Mohammad',
    lastName: 'Sabbir',
    email: 'sabbir.musfique01@gmail.com',
    phone: '01884952804',
    country: 'Bangladesh',
    state: 'Lakshmipur',
    city: 'Ramganj',
    birthday: '2002-06-25',
    password: 'examplepassword',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.menu),
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Profile Edit'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Notifications'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Picture
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/images/profile/sabbir_profile_pic.jpg'), // Placeholder or actual image URL
                  ),
                  const SizedBox(height: 10),
                  // User Name and Phone
                  Text(
                    '${user.firstName} ${user.lastName}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user.phone,
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  // Donation Stats
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('Donations',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey)),
                          Text('25,000 Tk',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Received',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey)),
                          Text('5,000 Tk',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Buttons for Donation History and Received Organization
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to Donation History
                          },
                          child: const Text('Donation History'),
                        ),
                      ),
                      const SizedBox(
                          width: 10), // Small space between the buttons
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to Received Organization
                          },
                          child: const Text('Received Organization'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),
                  // Additional User Details
                  UserDetailsItem(
                    icon: Icons.email,
                    label: user.email,
                  ),
                  UserDetailsItem(
                    icon: Icons.cake,
                    label: user.birthday,
                  ),
                  UserDetailsItem(
                    icon: Icons.location_on,
                    label: '${user.city}, ${user.state}, ${user.country}',
                  ),
                  const Divider(),
                  const SizedBox(height: 20),
                  const Text(
                    "My posts",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          // List of Posts
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final post = PostCardData.postCardData[index];
                return post.profileName == 'Mohammad Sabbir'
                    ? DonationPostCard(post: post)
                    : const SizedBox.shrink();
              },
              childCount: PostCardData.postCardData.length,
            ),
          ),
        ],
      ),
    );
  }
}

class UserDetailsItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const UserDetailsItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      // Navigate to Edit Profile
      break;
    case 1:
      // Notification Action
      break;
    case 2:
      // Logout Action
      break;
  }
}

// import 'package:flutter/material.dart';
// import 'package:one_connect_app/utils/constants/image_strings.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 200,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: const Text('My Profile'),
//               background: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   const CircleAvatar(
//                     backgroundImage: NetworkImage(
//                         'https://images.unsplash.com/photo-1595152772835-219674b2a8a6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwyMDg5NzF8MHwxfGFsbHwzfHx8fHx8fHwxNjEyODUxNTU3&ixlib=rb-1.2.1&q=80&w=400'), // Replace with your image URL
//                     radius: 20,
//                   ),
//                   Positioned(
//                     right: 16,
//                     top: 16,
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: IconButton(
//                         icon: const Icon(Icons.edit, color: Colors.green),
//                         onPressed: () {
//                           // Implement edit functionality
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

          
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Text(
//                     'Sandra Awiiri',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const Text('+256 704688781'),
//                 const SizedBox(height: 16),
//                 const DonationStatsWidget(),
//                 const Divider(),
//                 const ListTile(
//                   leading: Icon(Icons.email),
//                   title: Text('anna.alvaddo@gmail.com'),
//                 ),
//                 const ListTile(
//                   leading: Icon(Icons.calendar_today),
//                   title: Text('28/08/1991'),
//                 ),
//                 const ListTile(
//                   leading: Icon(Icons.location_on),
//                   title: Text('Najeera1, Kampala, Uganda'),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Implement logout functionality
//                     },
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: const Size(double.infinity, 50),
//                     ),
//                     child: const Text('Logout'),
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'My Posts',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (context, index) => const PostWidget(),
//               childCount: 3, // Replace with actual post count
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DonationStatsWidget extends StatelessWidget {
//   const DonationStatsWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _buildStatColumn('Donations', '35,000 Tk'),
//         _buildStatColumn('Received', '5,000 Tk'),
//         _buildStatColumn('Donation History', '→'),
//         _buildStatColumn('Received Organizations', '→'),
//       ],
//     );
//   }

//   Widget _buildStatColumn(String label, String value) {
//     return Column(
//       children: [
//         Text(label, style: const TextStyle(fontSize: 12)),
//         const SizedBox(height: 4),
//         Text(value,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//       ],
//     );
//   }
// }

// class PostWidget extends StatelessWidget {
//   const PostWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Card(
//       margin: EdgeInsets.all(8),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Help!',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Hello users, I need urgent money for new semester. Is there anyone help me out?',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text(
//               '3,000 Tk',
//               style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green),
//             ),
//             SizedBox(height: 8),
//             Row(
//               children: [
//                 Icon(Icons.remove_red_eye, size: 16),
//                 SizedBox(width: 4),
//                 Text('1000'),
//                 SizedBox(width: 16),
//                 Icon(Icons.thumb_up, size: 16),
//                 SizedBox(width: 4),
//                 Text('1k'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


