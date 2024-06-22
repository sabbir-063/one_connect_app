import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: OneColors.grey),
            borderRadius: BorderRadius.circular(150),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: OneSizes.iconLg,
              height: OneSizes.iconLg,
              image: AssetImage(OneImages.google),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: OneColors.grey),
            borderRadius: BorderRadius.circular(150),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: OneSizes.iconLg,
              height: OneSizes.iconLg,
              image: AssetImage(OneImages.facebook),
            ),
          ),
        ),
      ],
    );
  }
}
