import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});
  static String id = "notifications";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
