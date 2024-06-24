import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/features/authentication/screens/login/login.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomLeft,
              children: [
                // Cover photo
                Image.asset(
                  'assets/images/profile/cover_photo.jpg',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  bottom: -60,
                  left: 20,
                  child: Stack(
                    children: [
                      // Profile photo
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(
                            'assets/images/profile/sabbir_profile_pic.jpg'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 20,
                          child: Icon(Icons.camera_alt, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mohammad Sabbir Musfique',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Assalamualaikum\nCSE-21, MIST\nLast Blood Donate(O+) : 5 May 2024',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 110,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text('Edit Bio',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 110,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.edit, color: Colors.black),
                          label: const Text('Edit Profile',
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 110,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.logout, color: Colors.red),
                          label: const Text('Logout',
                              style: TextStyle(color: Colors.red)),
                          onPressed: () {
                            Get.to(() => const LoginScreen());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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


