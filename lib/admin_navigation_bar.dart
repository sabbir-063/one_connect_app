import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:one_connect_app/features/AdminChat/screens/admin_chat.dart';
import 'package:one_connect_app/features/AdminHomePage/screens/admin_home.dart';
import 'package:one_connect_app/features/AdminProfile/screens/admin_profile.dart';
import 'package:one_connect_app/features/AdminUserList/screens/admin_userlist.dart';

class AdminNavigationController extends GetxController {
  final Rx<int> selectedIndx = 0.obs;

  final screens = [
    AdminHomeScreen(),
    const AdminChatScreen(),
    const AdminUserlistScreen(),
    const AdminProfileScreen(),
  ];
}

class AdminNavigationBarMenu extends StatelessWidget {
  const AdminNavigationBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminNavigationController());

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
                label: "Admin Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.message),
                label: "Admin Chats",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.folder4),
                label: "User List",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.user),
                label: "Admin Profile",
              ),
            ],
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndx.value]),
    );
  }
}
