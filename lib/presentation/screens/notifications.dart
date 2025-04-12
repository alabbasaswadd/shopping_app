import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});
  static String id = "notifications";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("notifications".tr),
        centerTitle: true,
        elevation: 8,
        shadowColor: Colors.black,
      ),
    );
  }
}
