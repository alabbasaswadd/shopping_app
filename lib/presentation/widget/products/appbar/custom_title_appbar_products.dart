import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';

class CustomTitleAppbarProducts extends StatelessWidget {
  const CustomTitleAppbarProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextFormField(
        decoration: InputDecoration(
            filled: true,
            hintText: "Search...",
            hintStyle:
                TextStyle(color: Theme.of(context).colorScheme.onSurface),
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }
}
