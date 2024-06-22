import 'package:one_connect_app/common/styles/spacing_styles.dart';
import 'package:one_connect_app/utils/constants/sizes.dart';
import 'package:one_connect_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

import 'widgets/login_devider.dart';
import 'widgets/login_footer.dart';
import 'widgets/login_form.dart';
import 'widgets/login_title.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: OneSpacingStyles.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// login, title, sub title
              LoginTitle(),

              /// Form
              OneForm(),

              //Divider
              DividerText(dividerText: OneTexts.signInWith),

              SizedBox(height: OneSizes.spaceBtwSections / 2),

              //Footer
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
