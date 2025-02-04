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
      body: ListView.builder(
        itemCount: 9,
        itemBuilder: (context, i) => Container(
          padding: EdgeInsets.all(5),
          height: 200,
          child: Card(
            child: ListTile(
              title: Icon(
                Icons.home,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
