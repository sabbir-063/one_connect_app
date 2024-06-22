import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'features/HomePage/screens/HomeScreen/home.dart';
import 'utils/constants/colors.dart';
import 'utils/helpers/helper_functions.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndx = 0.obs;

  final screens = [
    const HomeScreen(),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.orange,
    ),
  ];
}

class NavigationBarMenu extends StatelessWidget {
  const NavigationBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = OneHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndx.value,
          onDestinationSelected: (indx) => controller.selectedIndx.value = indx,
          // backgroundColor: dark ? OneColors.grey : OneColors.grey,
          indicatorColor: dark
              ? OneColors.white.withOpacity(0.1)
              : const Color.fromARGB(255, 15, 104, 152).withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
            NavigationDestination(
                icon: Icon(Iconsax.heart_add), label: "Donation"),
            NavigationDestination(
                icon: Icon(Iconsax.folder4), label: "Donators"),
            NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndx.value]),
    );
  }
}
