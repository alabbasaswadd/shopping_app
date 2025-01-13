import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';

class CustomAlertDialogSettings extends StatelessWidget {
  CustomAlertDialogSettings(
      {super.key, required this.onOk, required this.onNo});
  final Function() onOk;
  final Function() onNo;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        MaterialButton(
          onPressed: onOk,
          child: Text("Yes"),
          color: AppColor.kPrimaryColor,
          textColor: AppColor.kWhiteColor,
        ),
        MaterialButton(
          onPressed: onNo,
          child: Text("No"),
          color: Colors.red,
          textColor: AppColor.kWhiteColor,
        ),
      ],
      title: Text(
        "Logout",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text("Do You Really Want To Get Out ?"),
    );
  }
}
