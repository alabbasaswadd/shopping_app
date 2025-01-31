import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/presentation/screens/home_screen.dart';
import 'package:shopping_app/presentation/screens/onboarding.dart';
import 'package:shopping_app/presentation/screens/products.dart';

import 'signup.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  static String id = "splash";
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      checkOnboardingStatus();
    });
  }

  Future<void> checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    if (hasSeenOnboarding) {
      // إذا شاهد المستخدم صفحات الـ onboarding مسبقًا
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignUp()),
      );
    } else {
      // إذا لم يشاهد المستخدم صفحات الـ onboarding
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Onboarding()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Image.asset("assets/images/logo2.jpeg")),
      ),
    );
  }
}
