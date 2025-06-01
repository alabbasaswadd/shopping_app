import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: child,
      ),
    );
  }
}
