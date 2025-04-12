import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.title});
  final Widget title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: true,
      elevation: 8,
      shadowColor: AppColor.kBlackColor,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
