import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});
  static String id = "payment";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
    );
  }
}
