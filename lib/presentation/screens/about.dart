import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});
  static String id = "about";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 8,
        title: Text("About"),
      ),
      body: Column(
        children: const [
          Card(
            elevation: 8,
            child: ListTile(
              title: Text("FaceBook"),
              leading: Icon(Icons.facebook),
            ),
          ),
          Card(
            elevation: 8,
            child: ListTile(
              title: Text("whatsApp"),
              leading: Icon(Icons.whatshot_sharp),
            ),
          ),
          Card(
            elevation: 8,
            child: ListTile(
              title: Text("Youtube"),
              leading: Icon(Icons.add_box_outlined),
            ),
          ),
          Card(
            elevation: 8,
            child: ListTile(
              title: Text("Telegram"),
              leading: Icon(Icons.telegram),
            ),
          ),
          Card(
            elevation: 8,
            child: ListTile(
              title: Text("Instagram"),
              leading: Icon(Icons.insert_page_break),
            ),
          ),
          Card(
            elevation: 8,
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
