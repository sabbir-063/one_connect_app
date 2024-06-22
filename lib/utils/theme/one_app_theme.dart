import 'package:one_connect_app/utils/theme/custom_themes/one_appbar_theme.dart';
import 'package:one_connect_app/utils/theme/custom_themes/one_bottom_sheet_theme.dart';
import 'package:one_connect_app/utils/theme/custom_themes/one_checkBox_theme.dart';
import 'package:one_connect_app/utils/theme/custom_themes/one_chip_theme.dart';
import 'package:one_connect_app/utils/theme/custom_themes/one_elevated_button_theme.dart';
import 'package:one_connect_app/utils/theme/custom_themes/one_outlined_button_theme.dart';
import 'package:one_connect_app/utils/theme/custom_themes/one_text_field_theme.dart';
import 'package:one_connect_app/utils/theme/custom_themes/one_text_theme.dart';
import 'package:flutter/material.dart';

class OneAppTheme {
  OneAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    primaryColor: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: OneTextTheme.lightText,
    elevatedButtonTheme: OneElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: OneAppbarTheme.lightAppBarTheme,
    bottomSheetTheme: OneBottomSheetTheme.lightBottomsheetTheme,
    checkboxTheme: OneCheckBoxTheme.lightCheckBoxTheme,
    chipTheme: OneChipTheme.lightChipTheme,
    outlinedButtonTheme: OneOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: OneTextFieldTheme.lightInputDecorationField,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    primaryColor: const Color.fromARGB(255, 77, 97, 114),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color.fromARGB(255, 26, 22, 22),
    textTheme: OneTextTheme.darkText,
    elevatedButtonTheme: OneElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: OneAppbarTheme.darkAppBarTheme,
    bottomSheetTheme: OneBottomSheetTheme.darkBottomsheetTheme,
    checkboxTheme: OneCheckBoxTheme.darkCheckBoxTheme,
    chipTheme: OneChipTheme.blackChipTheme,
    outlinedButtonTheme: OneOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: OneTextFieldTheme.darkInputDecorationField,
  );
}
