import 'package:flutter/material.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet(
      {super.key, required this.widget, required this.textBottomSheet});
  final Widget widget;
  final String textBottomSheet;
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        enableDrag: true,
        showDragHandle: true,
        onClosing: () {},
        builder: (context) => SizedBox(
            height: 260,
            child: Column(children: [
              Text(
                textBottomSheet,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: widget,
              )
            ])));
  }
}
