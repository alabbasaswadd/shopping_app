import 'package:flutter/material.dart';



class SettingsCard extends StatelessWidget {
  const SettingsCard(
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
