import 'package:flutter/material.dart';
import 'package:movies_app/utils/clolors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.blackColor,
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppColor.lightBlackColor,
    ),
    canvasColor: AppColor.lightBlackColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      showUnselectedLabels: true,
      unselectedItemColor: AppColor.greyColor,
      selectedItemColor: AppColor.yellowColor,
    ),
    textTheme: TextTheme(
        titleSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: AppColor.greyColor,
    )),
  );
}
