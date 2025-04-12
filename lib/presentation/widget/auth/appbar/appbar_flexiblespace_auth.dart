import 'package:flutter/material.dart';
import 'package:shopping_app/core/widgets/my_icon.dart';

class CustomFlexibleSpace extends StatelessWidget {
  const CustomFlexibleSpace({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    bool isLandscape = widthScreen > heightScreen;

    return Stack(children: <Widget>[
      MyIcon(
        icon: Icons.category_outlined,
        top: heightScreen * (isLandscape ? 0.10 : 0.05),
        left: widthScreen * 0.12,
        rotate: -0.2,
      ),
      MyIcon(
        icon: Icons.store_outlined,
        top: heightScreen * (isLandscape ? 0.08 : 0.025),
        left: widthScreen * 0.5,
        rotate: 0.1,
      ),
      MyIcon(
        icon: Icons.add_box_outlined,
        top: heightScreen * (isLandscape ? 0.12 : 0.05),
        left: widthScreen * 0.85,
      ),
      MyIcon(
        icon: Icons.calendar_today_outlined,
        top: heightScreen * (isLandscape ? 0.4 : 0.2),
        left: widthScreen * 0.13,
        rotate: -0.2,
      ),
      MyIcon(
        icon: Icons.verified,
        top: heightScreen * (isLandscape ? 0.4 : 0.2),
        left: widthScreen * 0.5,
      ),
      MyIcon(
        icon: Icons.store_outlined,
        top: heightScreen * (isLandscape ? 0.4 : 0.2),
        left: widthScreen * 0.85,
        rotate: 0.4,
      ),
    ]);
  }
}
