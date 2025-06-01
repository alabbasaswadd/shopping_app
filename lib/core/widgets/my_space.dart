import 'package:flutter/material.dart';

class MyVerticalSpace extends StatelessWidget {
  const MyVerticalSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 15);
  }
}

class MyHorizontalSpace extends StatelessWidget {
  const MyHorizontalSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 15);
  }
}
