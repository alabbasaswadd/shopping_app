import 'package:flutter/material.dart';
import 'package:shopping_app/view/screens/card.dart';
import 'package:shopping_app/view/screens/inside_produt.dart';
import 'package:shopping_app/view/screens/products.dart';
import 'package:shopping_app/view/screens/settings.dart';
import 'progres.dart';
import 'view/screens/login.dart';
import 'view/screens/home_screen.dart';
import 'view/screens/notifications.dart';
import 'view/screens/onboarding.dart';
import 'view/screens/splash.dart';

Map<String, Widget Function(BuildContext)> routes = {
  Login.id: (context) => Login(),
  Settings.id: (context) => Settings(),
  Productes.id: (context) => Productes(),
  InsideProdut.id: (context) => InsideProdut(),
  CardPage.id: (context) => CardPage(),
  Notifications.id: (context) => Notifications(),
  Progres.id: (context) => Progres(),
  HomeScreen.id: (context) => HomeScreen(),
  Onboarding.id: (context) => Onboarding(),
  Splash.id: (context) => Splash(),
};
