import 'package:flutter/material.dart';

PreferredSizeWidget myAppBar(String title, BuildContext context) {
  return AppBar(
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
