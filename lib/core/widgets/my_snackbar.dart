import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';

SnackBar mySnackBar() {
  return SnackBar(
    backgroundColor: Colors.white,
    content: ListTile(
      leading: VerticalDivider(thickness: 7, color: AppColor.kPrimaryColor),
      title: Text("Single-line snack bar with close affordance"),
      trailing: IconButton(
        onPressed: () {
          // إخفاء الـ Snackbar عند النقر على زر الإغلاق
        },
        icon: Icon(Icons.close),
      ),
    ),
  );
}
