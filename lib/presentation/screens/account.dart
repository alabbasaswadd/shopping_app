import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({super.key});
  static String id = "account";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
    );
  }
}
