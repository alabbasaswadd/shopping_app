import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});
  static String id = "about";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
    );
  }
}
