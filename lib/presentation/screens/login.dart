import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/presentation/screens/home_screen.dart';
import 'package:shopping_app/presentation/widget/auth/appbar/custom_flexiblespace.dart';
import 'package:shopping_app/presentation/widget/auth/custom_button.dart';
import 'package:shopping_app/presentation/widget/auth/custom_textfield.dart';

import 'signup.dart';

class Login extends StatefulWidget {
  Login({super.key});
  static String id = "login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: CustomFlexibleSpace(),
        title: Text("Login"),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        centerTitle: true,
        foregroundColor: Colors.white,
        toolbarHeight: 180,
      ),
      body: Stack(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Text(
                    "Welcome Back 👋",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Text(
                  "We happy to see you again. To use your account, you should log im first.",
                  textAlign: TextAlign.center,
                ),
                Container(
                    padding: EdgeInsets.only(left: 20),
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.centerLeft,
                    child: Text("Enter Your e-mail")),
                CustomTextfield(text: "Email"),
                Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text("Enter Your Password")),
                CustomTextfield(text: "Password", suffix: true),
                Row(
                  children: [
                    Checkbox(
                        checkColor: AppColor.kWhiteColor,
                        value: check,
                        onChanged: (val) {
                          setState(() {
                            check = val!;
                          });
                        }),
                    Text("Remmber me"),
                  ],
                ),
                CustomButton(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Do You Have Not An Account? ",
                      style: TextStyle(fontSize: 13),
                    ),
                    InkWell(
                      onTap: () {
                        Get.offAndToNamed(SignUp.id);
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                            color: AppColor.kPrimaryColor, fontSize: 13),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(HomeScreen.id);
                    },
                    child: Text(
                      "Browse No Account",
                      style: TextStyle(
                        color: AppColor.kPrimaryColor,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
