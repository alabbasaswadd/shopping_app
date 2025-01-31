import 'package:flutter/material.dart';
import 'package:shopping_app/presentation/widget/auth/appbar/custom_icon_appbar.dart';

class CustomFlexibleSpace extends StatelessWidget {
  const CustomFlexibleSpace({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    bool isLandscape = widthScreen > heightScreen; // التحقق من اتجاه الشاشة

    return Stack(children: <Widget>[
      CustomIconAppbar(
        icon: Icons.category_outlined,
        top: heightScreen *
            (isLandscape ? 0.10 : 0.05), // زيادة المسافة في الوضع العرضي
        left: widthScreen * 0.12,
        rotate: -0.2,
      ),
      CustomIconAppbar(
        icon: Icons.store_outlined,
        top: heightScreen * (isLandscape ? 0.08 : 0.025),
        left: widthScreen * 0.5,
        rotate: 0.1,
      ),
      CustomIconAppbar(
        icon: Icons.add_box_outlined,
        top: heightScreen * (isLandscape ? 0.12 : 0.05),
        left: widthScreen * 0.85,
      ),
      CustomIconAppbar(
        icon: Icons.calendar_today_outlined,
        top: heightScreen * (isLandscape ? 0.4 : 0.2),
        left: widthScreen * 0.13,
        rotate: -0.2,
      ),
      CustomIconAppbar(
        icon: Icons.verified,
        top: heightScreen * (isLandscape ? 0.4 : 0.2),
        left: widthScreen * 0.5,
      ),
      CustomIconAppbar(
        icon: Icons.store_outlined,
        top: heightScreen * (isLandscape ? 0.4 : 0.2),
        left: widthScreen * 0.85,
        rotate: 0.4,
      ),
    ]);
  }
}
