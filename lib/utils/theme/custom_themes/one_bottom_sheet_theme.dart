import 'package:flutter/material.dart';

class OneBottomSheetTheme {
  OneBottomSheetTheme._();

  static BottomSheetThemeData lightBottomsheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.white,
    modalBackgroundColor: Colors.white,
    constraints: BoxConstraints(maxWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
  static BottomSheetThemeData darkBottomsheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.black,
    modalBackgroundColor: Colors.black,
    constraints: BoxConstraints(maxWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}
