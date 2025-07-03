import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/core/constants/functions.dart';
import 'package:shopping_app/core/constants/images.dart';
import 'package:shopping_app/presentation/screens/home_screen.dart';
import 'package:shopping_app/presentation/screens/onboarding.dart';
import 'auth/signup.dart';

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
    Future.delayed(Duration(seconds: 3), () {
      checkOnboardingStatus();
    });
  }

  Future<void> checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    if (hasSeenOnboarding) {
      if (await UserPreferencesService.isLoggedIn()) {
        Get.offAllNamed(HomeScreen.id);
      } else {
        Get.offAllNamed(SignUp.id);
      }
    } else {
      Get.offAllNamed(Onboarding.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(AppImages.klogo)),
    );
  }
}
