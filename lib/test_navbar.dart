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
    const ProfileScreen(),
  ];
}

class CurvedNavigationBar extends StatelessWidget {
  const CurvedNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndx.value]),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: const Size(double.infinity, 80),
            painter: BNBCustomPainter(),
          ),
          Positioned(
            top: -30,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: const Icon(Iconsax.message, color: Colors.red),
              onPressed: () {
                controller.selectedIndx.value = 2; // Center icon index
              },
            ),
          ),
          Obx(
            () => Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 80,
                child: BottomNavigationBar(
                  currentIndex: controller.selectedIndx.value,
                  onTap: (indx) => controller.selectedIndx.value = indx,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.red,
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
                      icon: SizedBox.shrink(),
                      label: "",
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
          ),
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start point
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: const Radius.circular(40.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
