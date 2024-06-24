import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class AdminLoginTitle extends StatelessWidget {
  const AdminLoginTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Image(
          height: 150,
          width: 150,
          image: AssetImage(OneImages.darkAppLogo),
        ),
        Text(
          "Admin Login",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: OneSizes.sm),
        Text(
          OneTexts.loginSubTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        // const SizedBox(height: OneSizes.lg),
      ],
    );
  }
}
