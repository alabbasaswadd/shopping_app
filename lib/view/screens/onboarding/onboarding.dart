import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/data/model/onboarding_model.dart';
import 'package:shopping_app/data/repository/products_repository.dart';
import 'package:shopping_app/view/screens/auth/login.dart';
import 'package:shopping_app/view/screens/home_screen.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
  static String id = "onBoarding";
  static late int logisned;

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  List<OnboardingModel> model = [
    OnboardingModel(
        title: "This is page 1",
        image: "assets/images/onboarding1.jpg",
        body: "This is a body 1"),
    OnboardingModel(
        title: "This is page 2",
        image: "assets/images/onboarding2.png",
        body: "This is a body 2"),
    OnboardingModel(
        title: "This is page 3",
        image: "assets/images/onboarding3.png",
        body: "This is a body 3"),
    OnboardingModel(
        title: "This is page 4",
        image: "assets/images/onboarding4.png",
        body: "This is a body 4")
  ];
  @override
  void initState() {
    super.initState();
  }

  void ff() async {
    await ProductsRepository().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: PageView.builder(
            onPageChanged: (val) {},
            itemCount: 4,
            itemBuilder: (context, i) => Column(
                  children: [
                    SizedBox(height: 100),
                    MaterialButton(
                      color: AppColor.kPrimaryColor,
                      textColor: Colors.white,
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('hasSeenOnboarding', true);
                        Navigator.of(context)
                            .pushReplacementNamed(HomeScreen.id);
                      },
                      child: Text("Go To Honik"),
                    ),
                    Image.asset(
                      model[i].image,
                      width: 400,
                      height: 400,
                    ),
                    Text(
                      model[i].body,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                )),
      ),
    );
  }
}
