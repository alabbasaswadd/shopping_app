import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';

PreferredSizeWidget myAppBar(String title) {
  return AppBar(
    foregroundColor: Colors.white,
    elevation: 4,
    shadowColor: Colors.black,
    title: Text(title),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [AppColor.kPrimaryColor, AppColor.kSecondColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
  );
}
