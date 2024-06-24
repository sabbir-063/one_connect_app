import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:one_connect_app/features/DonationPage/screens/donation.dart';
import 'package:one_connect_app/features/DonatorsPage/screens/donator_list.dart';
import 'features/HomePage/screens/HomeScreen/home.dart';
import 'features/ProfilePage/screens/profile.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndx = 0.obs;

  final screens = [
    const HomeScreen(),
    const DonationPageScreen(),
    const DonatorListScreen(),
    const ProfileScreen(),
  ];
}

class NavigationBarMenu extends StatelessWidget {
  const NavigationBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
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
                icon: Icon(Iconsax.folder4),
                label: "Donators",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.user),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndx.value]),
    );
  }
}
