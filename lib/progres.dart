import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopping_app/core/constants/colors.dart';

class Progres extends StatelessWidget {
  const Progres({super.key});
  static String id = "progres";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitWave(
            color: AppColor.kPrimaryColor,
            size: 50.0,
          ),
          SpinKitChasingDots(color: AppColor.kPrimaryColor, size: 50.0),
          SpinKitRing(color: AppColor.kPrimaryColor, size: 50.0),
          SpinKitFadingGrid(color: AppColor.kPrimaryColor, size: 50.0),
          SpinKitDancingSquare(color: AppColor.kPrimaryColor, size: 50.0),
          SpinKitCircle(color: AppColor.kPrimaryColor, size: 50.0),
          SpinKitFadingCube(color: AppColor.kPrimaryColor, size: 50.0),
        ],
      )),
    );
  }
}
