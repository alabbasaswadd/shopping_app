import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopping_app/core/constants/colors.dart';


class MyIndicator extends StatelessWidget {
  const MyIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitChasingDots(color: AppColor.kPrimaryColor);
  }
}
