import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/presentation/business_logic/cubit/products/products_cubit.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/data/model/onboarding_model.dart';
import 'package:shopping_app/data/repository/products_repository.dart';
import 'package:shopping_app/data/web_services/products_web_services.dart';
import 'package:shopping_app/presentation/screens/home_screen.dart';

// ignore: must_be_immutable
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
        title: "Welcome to the world of easy shopping!",
        image: "assets/images/onboarding1.jpg",
        body:
            "Enjoy a convenient and fast shopping experience with the best products and special offers."),
    OnboardingModel(
        title: "Everything you need in one place!",
        image: "assets/images/onboarding2.png",
        body:
            "Discover a wide range of products that meet all your needs, easily and from anywhere."),
    OnboardingModel(
        title: "Shop with confidence and security!",
        image: "assets/images/onboarding3.png",
        body:
            "We guarantee you a safe shopping experience with multiple payment options and reliable delivery service."),
    OnboardingModel(
        title: "Start now!",
        image: "assets/images/onboarding4.png",
        body:
            "Create your account or log in to discover everything new and special.")
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProductsCubit(Repository(WebServices())),
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(20),
            child: PageView.builder(
                onPageChanged: (val) {},
                itemCount: 4,
                itemBuilder: (context, i) => Column(
                      children: [
                        MaterialButton(
                          color: AppColor.kPrimaryColor,
                          textColor: Colors.white,
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('hasSeenOnboarding', true);
                            Get.offAndToNamed(HomeScreen.id);
                          },
                          child: Text("Go To Honik"),
                        ),
                        SizedBox(height: 100),
                        Image.asset(model[i].image, width: 200, height: 200),
                        Text(
                          model[i].title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: AppColor.kThirtColorDarkMode,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30),
                        Text(
                          model[i].body,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: AppColor.kSecondColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
          ),
        ));
  }
}
