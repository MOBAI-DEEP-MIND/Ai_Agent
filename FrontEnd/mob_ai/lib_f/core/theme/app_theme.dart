import 'package:flutter/material.dart';

import 'app_pallete.dart';

class AppTheme {
  // static _border() => OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(10),
  //       borderSide: BorderSide(
  //         color:Colors.blue,
  //         width: 2,
  //       ),
  //     );
  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    primaryColor: AppPallete.primaryColor,
  );
  // copyWith(

  //   scaffoldBackgroundColor: AppPallete.backgroundColor,
  //   appBarTheme: AppBarTheme(color: AppPallete.backgroundColor),
  //   chipTheme: ChipThemeData(
  //     color: WidgetStatePropertyAll(AppPallete.backgroundColor)
  //   ),
  //   inputDecorationTheme: InputDecorationTheme(
  //     contentPadding: const EdgeInsets.all(27),
  //     enabledBorder: _border(),
  //     focusedBorder: _border(AppPallete.gradient1),
  //     errorBorder: _border(AppPallete.errorColor),
  //   ),
  // );
}
