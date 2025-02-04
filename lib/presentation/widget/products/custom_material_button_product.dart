import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';

class CustomMaterialButtonProduct extends StatelessWidget {
  const CustomMaterialButtonProduct(
      {super.key, required this.text, required this.color, this.colorText});
  final String text;
  final Color color;
  final Color? colorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: AppColor.kPrimaryColor,
          )),
      child: MaterialButton(
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(fontSize: 25, color: colorText),
        ),
      ),
    );
  }
}
