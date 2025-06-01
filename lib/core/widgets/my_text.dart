import 'package:flutter/material.dart';

class MyTextMedium extends StatelessWidget {
  const MyTextMedium(
      {super.key,
      required this.text,
      this.align = Alignment.centerLeft,
      this.color});
  final String text;
  final AlignmentGeometry? align;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      margin: const EdgeInsets.only(top: 20),
      alignment: align,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
      ),
    );
  }
}

class MyTextLarge extends StatelessWidget {
  const MyTextLarge(
      {super.key,
      required this.text,
      this.align = Alignment.centerLeft,
      this.color});
  final String text;
  final AlignmentGeometry? align;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      margin: const EdgeInsets.only(top: 15),
      alignment: align,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

class MyTextSmall extends StatelessWidget {
  const MyTextSmall(
      {super.key,
      required this.text,
      this.align = Alignment.centerLeft,
      this.color});
  final String text;
  final AlignmentGeometry? align;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      margin: const EdgeInsets.only(top: 20),
      alignment: align,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
      ),
    );
  }
}
