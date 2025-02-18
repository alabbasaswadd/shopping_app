import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/images.dart';

class Account extends StatelessWidget {
  const Account({super.key});
  static String id = "account";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 8,
        title: Text("Account"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.asset(AppImages.klogo),
          Card(
            elevation: 8,
            child: ListTile(
              title: Text("Change username"),
              trailing: Icon(Icons.forward),
            ),
          ),
          Card(
            elevation: 8,
            child: ListTile(
              title: Text("Change password"),
              trailing: Icon(Icons.forward),
            ),
          ),
          Card(
            elevation: 8,
            child: ListTile(
              title: Text("Change Number"),
              trailing: Icon(Icons.forward),
            ),
          ),
          Card(
            elevation: 8,
            child: ListTile(
              title: Text("Change email"),
              trailing: Icon(Icons.forward),
            ),
          ),
        ],
      ),
    );
  }
}
