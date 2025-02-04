import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';

class CustomAlertDialogSettings extends StatelessWidget {
  const CustomAlertDialogSettings(
      {super.key, required this.onOk, required this.onNo});
  final Function() onOk;
  final Function() onNo;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        MaterialButton(
          onPressed: onOk,
          color: AppColor.kPrimaryColor,
          textColor: AppColor.kWhiteColor,
          child: Text("Yes"),
        ),
        MaterialButton(
          onPressed: onNo,
          color: Colors.red,
          textColor: AppColor.kWhiteColor,
          child: Text("No"),
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
