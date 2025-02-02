import 'package:flutter/material.dart';

class Offers extends StatelessWidget {
  const Offers({super.key});
  static String id = "offers";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offers"),
      ),
    );
  }
}
