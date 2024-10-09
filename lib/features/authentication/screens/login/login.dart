// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/common/styles/spacing_styles.dart';
import 'package:one_connect_app/features/authentication/screens/AdminLogin/admin_login.dart';
import 'package:one_connect_app/utils/constants/sizes.dart';
// import 'package:one_connect_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

// import 'widgets/login_devider.dart';
import 'widgets/login_footer.dart';
import 'widgets/login_form.dart';
import 'widgets/login_title.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use WidgetsBinding to request permission after the first frame is built
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //     if (!isAllowed) {
    //       AwesomeNotifications().requestPermissionToSendNotifications();
    //     }
    //   });
    // });

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: OneSpacingStyles.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// login, title, sub title
              const LoginTitle(),

              /// Form
              OneForm(),

              //Divider
              // const DividerText(dividerText: OneTexts.signInWith),

              // const SizedBox(height: OneSizes.spaceBtwSections / 2),

              //Footer
              const Footer(),

              const SizedBox(height: OneSizes.spaceBtwSections),

              GestureDetector(
                onTap: () {
                  Get.offAll(() => const AdminLoginScreen());
                },
                child: const Text(
                  "Login as Admin",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                    // fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    decorationThickness: 1,
                  ),
                ),
              ),

              ///
            ],
          ),
        ),
      ),
    );
  }
}
