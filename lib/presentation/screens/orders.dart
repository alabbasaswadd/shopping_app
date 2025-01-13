import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});
  static String id = "orders";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
    );
  }
}
