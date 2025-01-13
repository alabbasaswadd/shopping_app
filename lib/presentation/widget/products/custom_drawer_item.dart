import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';

class CustomDrawerItem extends StatelessWidget {
  const CustomDrawerItem({
    super.key,
    required this.icon,
    required this.title,
    this.color = const Color(0xff5673cc), required this.ontap,
  });
  final IconData icon;
  final String title;
  final Color? color;
  final Function() ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        elevation: 8,
        child: ListTile(
          leading: Icon(
            icon,
            color: color,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: AppColor.kPrimaryColor,
          ),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
