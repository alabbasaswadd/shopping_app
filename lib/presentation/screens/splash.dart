import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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
  final Connectivity _connectivity = Connectivity();
  bool _isCheckingInternet = true;
  bool _hasInternet = false;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _initConnectivity();
    _setupConnectivityListener();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _initConnectivity() async {
    await _checkInternetAndNavigate();
  }

  void _setupConnectivityListener() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((results) {
      if (results.isNotEmpty &&
          results.any((result) => result != ConnectivityResult.none) &&
          !_hasInternet) {
        _checkInternetAndNavigate();
      }
    });
  }

  Future<void> _checkInternetAndNavigate() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    final hasInternetNow = connectivityResult.isNotEmpty &&
        connectivityResult.any((result) => result != ConnectivityResult.none);

    if (mounted) {
      setState(() {
        _isCheckingInternet = false;
        _hasInternet = hasInternetNow;
      });
    }

    if (hasInternetNow) {
      await Future.delayed(const Duration(seconds: 3));
      await checkOnboardingStatus();
    }
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
      body: _isCheckingInternet
          ? const Center(child: CircularProgressIndicator())
          : _hasInternet
              ? Center(child: Image.asset(AppImages.klogo))
              : _NoInternetConnection(),
    );
  }
}

class _NoInternetConnection extends StatelessWidget {
  const _NoInternetConnection();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.wifi_off, size: 80, color: Colors.red),
          SizedBox(height: 20),
          Text(
            'لا يوجد اتصال بالإنترنت',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'جاري محاولة الاتصال تلقائياً...',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 30),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
