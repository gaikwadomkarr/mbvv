import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'color_constants.dart';

// This is our  main focus
// Let's apply light and dark theme on our app
// Now let's add dark theme on our app

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      caption:
          TextStyle(color: white, fontSize: 15.sp, fontWeight: FontWeight.w500),
      headline1: TextStyle(
          color: primaryColor, fontSize: 15.sp, fontWeight: FontWeight.normal),
      headline2: TextStyle(
          color: white, fontSize: 15.sp, fontWeight: FontWeight.normal),
      headline3: TextStyle(
          color: black, fontSize: 15.sp, fontWeight: FontWeight.normal),
      headline4: TextStyle(
          color: grey, fontSize: 15.sp, fontWeight: FontWeight.normal),
      headline5: TextStyle(
          color: primaryColor, fontSize: 12.sp, fontWeight: FontWeight.normal),
      headline6: TextStyle(
          color: white, fontSize: 12.sp, fontWeight: FontWeight.normal),
      subtitle1: TextStyle(
          color: black, fontSize: 12.sp, fontWeight: FontWeight.normal),
      subtitle2: TextStyle(
          color: grey, fontSize: 12.sp, fontWeight: FontWeight.normal),
    ),
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: white,
    ),
  );
}
