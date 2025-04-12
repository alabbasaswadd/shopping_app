import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_button.dart';
import 'package:shopping_app/core/widgets/my_text_form_field.dart';
import 'package:shopping_app/presentation/screens/home_screen.dart';
import 'package:shopping_app/presentation/screens/login.dart';
import 'package:shopping_app/presentation/widget/auth/appbar/appbar_flexiblespace_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  static String id = "signUp";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool check = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: CustomFlexibleSpace(),
        title: Text("SignUp".tr),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        centerTitle: true,
        foregroundColor: Colors.white,
        toolbarHeight: 180,
      ),
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Welcome_Back".tr,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "welcome_message".tr,
                  textAlign: TextAlign.center,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text("email".tr),
                ),
                MyTextFormField(
                  label: "email".tr,
                  controller: emailController,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text("enter_password".tr),
                ),
                MyTextFormField(
                  label: "password".tr,
                  suffix: true,
                  controller: passwordController,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text("confirm_password".tr),
                ),
                MyTextFormField(
                  label: "confirm_password".tr,
                  suffix: true,
                  controller: confirmPasswordController,
                ),
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
                    Text("remember_me".tr),
                  ],
                ),
                MyButton(text: "SignUp".tr, onPressed: () {}),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "do_you_have_an_account ? ".tr,
                      style: const TextStyle(fontSize: 13),
                    ),
                    InkWell(
                      onTap: () {
                        Get.offAndToNamed(Login.id);
                      },
                      child: Text(
                        "login".tr,
                        style: TextStyle(
                            color: AppColor.kPrimaryColor, fontSize: 13),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    Get.offAllNamed(HomeScreen.id);
                  },
                  child: Text(
                    "browse_no_account".tr,
                    style: TextStyle(
                      color: AppColor.kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
