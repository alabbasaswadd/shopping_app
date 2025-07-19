import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_animation.dart';
import 'package:shopping_app/core/widgets/my_text.dart';

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
        MyAnimation(
          scale: 0.85,
          child: MaterialButton(
            onPressed: onOk,
            color: AppColor.kPrimaryColor,
            textColor: AppColor.kWhiteColor,
            child: CairoText("yes".tr, color: Colors.white),
          ),
        ),
        MyAnimation(
          scale: 0.85,
          child: MaterialButton(
            onPressed: onNo,
            color: Colors.red,
            textColor: AppColor.kWhiteColor,
            child: CairoText("no".tr, color: Colors.white),
          ),
        ),
      ],
      title: CairoText(title),
      content: CairoText(
        content,
        color: Colors.black54,
      ),
    );
  }
}
