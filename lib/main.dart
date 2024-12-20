import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/business_logic/cubit/localazations/localazations_cubit.dart';
import 'package:shopping_app/core/constants/theme.dart';
import 'package:shopping_app/view/screens/splash.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تحميل اللغة المحفوظة
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String savedLanguage = prefs.getString('language') ?? 'en';

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocalazationsCubit()
            ..changeLang(savedLanguage), // تعيين اللغة المحفوظة
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalazationsCubit, Locale>(
      builder: (context, locale) {
        return AdaptiveTheme(
          light: lightTheme,
          dark: darkTheme,
          initial: AdaptiveThemeMode.light,
          builder: (theme, darkTheme) => MaterialApp(
            locale: locale,
            localizationsDelegates: const [
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('ar', ''),
            ],
            theme: theme,
            darkTheme: darkTheme,
            routes: routes,
            debugShowCheckedModeBanner: false,
            initialRoute: Splash.id,
          ),
        );
      },
    );
  }
}
