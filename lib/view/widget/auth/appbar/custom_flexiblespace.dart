import 'package:flutter/material.dart';
import 'package:shopping_app/view/widget/auth/appbar/custom_icon_appbar.dart';

class CustomFlexiblespace extends StatelessWidget {
  const CustomFlexiblespace({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      CustomIconAppbar(
        icon: Icons.category_outlined,
        top: 40,
        left: 50,
        rotate: -0.2,
      ),
      CustomIconAppbar(
        icon: Icons.store_outlined,
        top: 20,
        left: 200,
        rotate: 0.1,
      ),
      CustomIconAppbar(icon: Icons.add_box_outlined, top: 40, left: 350),
      CustomIconAppbar(
        icon: Icons.calendar_today_outlined,
        top: 150,
        left: 70,
        rotate: -0.2,
      ),
      CustomIconAppbar(icon: Icons.verified, top: 150, left: 200),
      CustomIconAppbar(
        icon: Icons.store_outlined,
        top: 150,
        left: 350,
        rotate: 0.4,
      ),
    ]);
  }
}
