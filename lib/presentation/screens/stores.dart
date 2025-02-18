import 'package:flutter/material.dart';

class Stores extends StatelessWidget {
  const Stores({super.key});
  static String id = "stores";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Stores"),
          centerTitle: true,
          elevation: 8,
          shadowColor: Colors.black,
        ),
        body: GridView.builder(
          itemCount: 10,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, i) => Card(
            child: Center(child: Text("Store")),
          ),
        ));
  }
}
