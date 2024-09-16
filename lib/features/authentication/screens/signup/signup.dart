// import 'package:one_connect_app/features/authentication/screens/login/widgets/login_devider.dart';
// import 'package:one_connect_app/features/authentication/screens/login/widgets/login_footer.dart';
import 'package:one_connect_app/utils/constants/sizes.dart';
import 'package:one_connect_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(OneSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///title
              Text(
                OneTexts.letsCreate,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: OneSizes.spaceBtwSections),

              ///Form
              const SignUpForm(),
              // const SizedBox(height: OneSizes.spaceBtwSections),

              ///Divier text
              // const DividerText(dividerText: OneTexts.signUpWith),
              // const SizedBox(height: OneSizes.spaceBtwSections / 2),

              ///Social media
              // const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
