import 'package:flutter/material.dart';

PreferredSizeWidget myAppBar(
    {String title = "", required BuildContext context, List<Widget>? actions}) {
  return AppBar(
    actions: actions,
    foregroundColor: Colors.white,
    elevation: 8,
    shadowColor: Colors.black,
    title: Text(title),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    ),
  );
}
