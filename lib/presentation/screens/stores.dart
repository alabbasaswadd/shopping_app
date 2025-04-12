import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_app/core/widgets/my_card.dart';

class Stores extends StatelessWidget {
  const Stores({super.key});
  static String id = "stores";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("stores".tr),
          centerTitle: true,
          elevation: 8,
          shadowColor: Colors.black,
        ),
        body: GridView.builder(
          itemCount: 12,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemBuilder: (context, i) => MyCard(
            child: Center(child: Text("Store")),
          ),
        ));
  }
}
