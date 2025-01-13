import 'package:flutter/material.dart';

class CustomSnacbar extends StatelessWidget {
  const CustomSnacbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: ListTile(
        title: Text("data"),
        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
      ),
    );
  }
}
