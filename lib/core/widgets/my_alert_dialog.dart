import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog(
      {super.key,
      required this.onOk,
      required this.onNo,
      required this.title,
      required this.content});
  final Function() onOk;
  final Function() onNo;
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
      actions: [
        MaterialButton(
          onPressed: onOk,
          color: AppColor.kPrimaryColor,
          textColor: AppColor.kWhiteColor,
          child: Text("yes".tr),
        ),
        MaterialButton(
          onPressed: onNo,
          color: Colors.red,
          textColor: AppColor.kWhiteColor,
          child: Text("no".tr),
        ),
      ],
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(content),
    );
  }
}
