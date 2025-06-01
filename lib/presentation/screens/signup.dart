import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_button.dart';
import 'package:shopping_app/core/widgets/my_card.dart';
import 'package:shopping_app/core/widgets/my_space.dart';
import 'package:shopping_app/core/widgets/my_text.dart';
import 'package:shopping_app/core/widgets/my_text_form_field.dart';
import 'package:shopping_app/data/repository/products_repository.dart';
import 'package:shopping_app/data/web_services/products_web_services.dart';
import 'package:shopping_app/presentation/business_logic/cubit/auth/auth_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/auth/auth_state.dart';
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
  // Controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();

  int gender = 0;
  bool defaultAddress = true;
  late AuthCubit cubit;
  @override
  void initState() {
    cubit = AuthCubit();
    super.initState();
  }

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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff76c6f2),
                Color(0xff5673cc),
                Color(0xffa3ffcc),
                Color(0xffa3e8b8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.3, 0.6, 1.0],
            ),
          ),
          padding: EdgeInsets.all(13),
          child: MyCard(
            child: Container(
              padding: const EdgeInsets.all(5),
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MyTextLarge(
                        text: "Welcome_Back".tr, align: Alignment.center),
                    MyTextMedium(
                        text: "welcome_message".tr, align: Alignment.center),
                    MyTextMedium(text: "first_name".tr),
                    MyTextFormField(
                        label: "first_name".tr,
                        controller: firstNameController),
                    MyTextMedium(text: "last_name".tr),
                    MyTextFormField(
                        label: "last_name".tr, controller: lastNameController),
                    MyTextMedium(text: "birth_date".tr),
                    MyTextFormField(
                      label: "birth_date".tr,
                      controller: birthDateController,
                    ),
                    MyTextMedium(text: "gender".tr),
                    DropdownButton<int>(
                      value: gender,
                      onChanged: (val) {
                        setState(() {
                          gender = val!;
                        });
                      },
                      items: [
                        DropdownMenuItem(value: 0, child: Text("male".tr)),
                        DropdownMenuItem(value: 1, child: Text("female".tr)),
                      ],
                    ),
                    MyTextMedium(text: "phone".tr),
                    MyTextFormField(
                        label: "phone".tr, controller: phoneController),
                    MyTextMedium(text: "email".tr),
                    MyTextFormField(
                        label: "email".tr, controller: emailController),
                    MyTextMedium(text: "enter_password".tr),
                    MyTextFormField(
                        label: "password".tr,
                        controller: passwordController,
                        suffix: true),
                    MyTextMedium(text: "confirm_password".tr),
                    MyTextFormField(
                        label: "confirm_password".tr,
                        controller: confirmPasswordController,
                        suffix: true),
                    MyTextMedium(text: "city".tr),
                    MyTextFormField(
                        label: "city".tr, controller: cityController),
                    MyTextMedium(text: "street".tr),
                    MyTextFormField(
                        label: "street".tr, controller: streetController),
                    MyTextMedium(text: "floor".tr),
                    MyTextFormField(
                        label: "floor".tr, controller: floorController),
                    MyTextMedium(text: "apartment".tr),
                    MyTextFormField(
                        label: "apartment".tr, controller: apartmentController),
                    Row(
                      children: [
                        Checkbox(
                          value: defaultAddress,
                          onChanged: (val) {
                            setState(() {
                              defaultAddress = val ?? true;
                            });
                          },
                        ),
                        Text("use_as_default_address".tr),
                      ],
                    ),
                    MyVerticalSpace(),
                    MyButton(
                      text: "SignUp".tr,
                      onPressed: () {
                        cubit.signup(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            birthDate: birthDateController.text,
                            gender: 0,
                            email: emailController.text,
                            phone: phoneController.text,
                            password: passwordController.text,
                            address: apartmentController.text,
                            city: cityController.text,
                            street: streetController.text,
                            floor: floorController.text,
                            apartment: apartmentController.text,
                            defaultAddress: true);
                        print("================================" +
                            firstNameController.text);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("do_you_have_an_account ? ".tr,
                            style: const TextStyle(fontSize: 13)),
                        InkWell(
                          onTap: () => Get.offAndToNamed(Login.id),
                          child: Text("login".tr,
                              style: TextStyle(
                                  color: AppColor.kPrimaryColor, fontSize: 13)),
                        )
                      ],
                    ),
                    MyVerticalSpace(),
                    InkWell(
                      onTap: () => Get.offAllNamed(HomeScreen.id),
                      child: Text("browse_no_account".tr,
                          style: TextStyle(color: AppColor.kPrimaryColor)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
