import 'package:flutter/material.dart';
import 'package:shopping_app/core/widgets/my_text.dart';

PreferredSizeWidget myAppBar(
    {String title = "", required BuildContext context, List<Widget>? actions}) {
  return AppBar(
    actions: actions,
    foregroundColor: Colors.white,
    elevation: 8,
    shadowColor: Colors.black,
    title: CairoText(title, color: Colors.white),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    ),
  );
}
