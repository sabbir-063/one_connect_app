import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class DividerText extends StatelessWidget {
  const DividerText({super.key, required this.dividerText});

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark = OneHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Divider(
          color: dark ? OneColors.darkGrey : OneColors.grey,
          thickness: 0.5,
          indent: 60,
          endIndent: 5,
        ),
        Text(dividerText, style: Theme.of(context).textTheme.labelMedium),
        Divider(
          color: dark ? OneColors.darkGrey : OneColors.grey,
          thickness: 0.5,
          indent: 5,
          endIndent: 60,
        ),
      ],
    );
  }
}
