import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_app/core/widgets/my_card.dart';

class About extends StatelessWidget {
  const About({super.key});
  static String id = "about";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 8,
        title: Text("about".tr),
      ),
      body: Column(
        children: const [
          MyCard(
            child: ListTile(
              title: Text("FaceBook"),
              leading: Icon(Icons.facebook),
            ),
          ),
          MyCard(
            child: ListTile(
              title: Text("whatsApp"),
              leading: Icon(Icons.whatshot_sharp),
            ),
          ),
          MyCard(
            child: ListTile(
              title: Text("Youtube"),
              leading: Icon(Icons.add_box_outlined),
            ),
          ),
          MyCard(
            child: ListTile(
              title: Text("Telegram"),
              leading: Icon(Icons.telegram),
            ),
          ),
          MyCard(
            child: ListTile(
              title: Text("Instagram"),
              leading: Icon(Icons.insert_page_break),
            ),
          ),
          MyCard(
            child: ListTile(
              title: Text("X"),
              leading: Icon(Icons.one_x_mobiledata),
            ),
          ),
        ],
      ),
    );
  }
}
