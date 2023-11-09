import 'package:flutter/material.dart';
import 'package:movies_app/utils/colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.blackColor,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColor.whiteColor),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppColor.lightBlackColor,
    ),
    canvasColor: AppColor.lightBlackColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      showUnselectedLabels: true,
      unselectedItemColor: AppColor.offWhiteColor,
      selectedItemColor: AppColor.yellowColor,
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColor.offWhiteColor,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: AppColor.whiteColor,
      ),
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: AppColor.whiteColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColor.whiteColor,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColor.lightGreyColor,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: AppColor.greyColor,
      thickness: 1,
    ),
  );
}
