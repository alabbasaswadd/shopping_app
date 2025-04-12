import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/images.dart';
import 'package:shopping_app/core/widgets/my_card.dart';

class Account extends StatelessWidget {
  const Account({super.key});
  static String id = "account";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 8,
        title: Text("account".tr),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.asset(AppImages.klogo),
          MyCard(
            child: ListTile(
              title: Text("change_username".tr),
              trailing: const Icon(Icons.forward),
            ),
          ),
          MyCard(
            child: ListTile(
              title: Text("change_password".tr),
              trailing: const Icon(Icons.forward),
            ),
          ),
          MyCard(
            child: ListTile(
              title: Text("change_number".tr),
              trailing: const Icon(Icons.forward),
            ),
          ),
          MyCard(
            child: ListTile(
              title: Text("change_email".tr),
              trailing: const Icon(Icons.forward),
            ),
          ),
        ],
      ),
    );
  }
}
