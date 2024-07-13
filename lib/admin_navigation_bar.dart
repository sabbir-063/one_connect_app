import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:one_connect_app/features/AdminChat/screens/admin_chat_list.dart';
import 'package:one_connect_app/features/AdminHomePage/screens/admin_home.dart';
import 'package:one_connect_app/features/AdminProfile/screens/admin_profile.dart';
import 'package:one_connect_app/features/AdminUserList/screens/admin_userlist.dart';

import 'features/AdminPostPage/screens/admin_post.dart';

class AdminNavigationController extends GetxController {
  final Rx<int> selectedIndx = 0.obs;

  final screens = [
    const AdminPostScreen(),
    const AdminHomeScreen(),
    AdminChatListScreen(),
    AdminUserlistScreen(),
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
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.presention_chart),
                label: "Posts",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.message),
                label: "Chats",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.folder4),
                label: "User List",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.bus),
                label: "Statics",
              ),
            ],
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndx.value]),
    );
  }
}
