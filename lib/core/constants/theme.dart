import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: AppColor.kPrimaryColor,
    onPrimary: AppColor.kPrimaryColor,
    secondary: AppColor.kThirtColor,
    onSecondary: AppColor.kPrimaryColor,
    error: AppColor.kRedColor,
    onError: AppColor.kRedColor,
    surface: AppColor.kWhiteColor,
    onSurface: AppColor.kBlackColor,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w700,
      fontFamily: "SFProText-Bold",
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      fontFamily: "SFProText-Bold",
      color: Colors.black,
    ),
    bodySmall: TextStyle(fontSize: 15, color: Colors.grey),
  ),
);
ThemeData darkTheme = ThemeData(
  switchTheme:
      const SwitchThemeData(thumbColor: WidgetStatePropertyAll(Colors.white)),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: AppColor.kPrimaryColor,
    onPrimary: AppColor.kThirtColorDarkMode,
    secondary: AppColor.kSecondColorDarkMode,
    onSecondary: AppColor.kSecondColorDarkMode,
    error: AppColor.kRedColor,
    onError: AppColor.kRedColor,
    surface: AppColor.kPrimaryColorDarkMode,
    onSurface: AppColor.kWhiteColor,
  ),
  iconTheme: IconThemeData(color: AppColor.kPrimaryColor),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w700,
      fontFamily: "SFProText-Bold",
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      fontFamily: "SFProText-Bold",
      color: Colors.white,
    ),
    bodySmall: TextStyle(fontSize: 15, color: Colors.grey),
  ),
);
