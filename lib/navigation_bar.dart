import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:one_connect_app/features/DonationPage/screens/donation.dart';
import 'package:one_connect_app/features/DonatorsPage/screens/donator_list.dart';
import 'features/HomePage/screens/HomeScreen/home.dart';
import 'features/MessagePage/screens/user_chat_screen.dart';
import 'features/ProfilePage/screens/profile.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndx = 0.obs;

  final screens = [
    const HomeScreen(),
    DonationPageScreen(),
    UserChatScreen(),
    DonatorListScreen(),
    // const NotificationScreen(),
    const ProfileScreen(),
  ];

  // void goToProfile() {
  //   selectedIndx.value = 4; // Set the index to 4 (Profile)
  //   // Get.to(() => ProfileScreen()); // Navigate to the ProfileScreen
  // }
}

class NavigationBarMenu extends StatelessWidget {
  const NavigationBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndx.value]),
      bottomNavigationBar: Obx(
        () => SizedBox(
          height: 80,
          child: BottomNavigationBar(
            currentIndex: controller.selectedIndx.value,
            onTap: (indx) => controller.selectedIndx.value = indx,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
            iconSize: 25,
            selectedFontSize: 14,
            unselectedFontSize: 12,
            // unselectedLabelStyle: TextStyle(fontSize: 12),
            // selectedLabelStyle: TextStyle(fontSize: 12),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Iconsax.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.heart_add),
                label: "Donation",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.message),
                label: "Messages",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.folder4),
                label: "Donators",
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Iconsax.notification),
              //   label: "Notification",
              // ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.user),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
