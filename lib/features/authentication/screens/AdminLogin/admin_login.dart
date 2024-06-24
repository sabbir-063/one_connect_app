import 'package:one_connect_app/common/styles/spacing_styles.dart';

import 'package:flutter/material.dart';

import 'widgets/admin_login_form.dart';
import 'widgets/admin_login_title.dart';


class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: OneSpacingStyles.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// login, title, sub title
              AdminLoginTitle(),

              /// Form
              AdminLoginForm(),

            ],
          ),
        ),
      ),
    );
  }
}
