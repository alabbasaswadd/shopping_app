import 'package:flutter/material.dart';

class CustomBottomSheetSettings extends StatelessWidget {
  const CustomBottomSheetSettings(
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

class CustomCardSettings extends StatelessWidget {
  const CustomCardSettings(
      {super.key, this.lang, required this.onChanged, this.widget});
  final String? lang;
  final Function(Object? val) onChanged;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Card(
        elevation: 8,
        color: Theme.of(context).colorScheme.secondary,
        child: InkWell(onTap: () {}, child: widget),
      ),
    );
  }
}
