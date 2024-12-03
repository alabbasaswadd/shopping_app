import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shopping_app/business_logic/cubit/localazations/localazations_cubit.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/progres.dart';
import 'package:shopping_app/view/screens/home_screen.dart';
import 'package:shopping_app/view/screens/onboarding/onboarding.dart';
import 'package:shopping_app/view/screens/onboarding/splash.dart';
import 'routes.dart';
import 'translations.dart';
import 'view/screens/settings/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyI18n.loadTranslations(); // تغيير إلى 'en' عند الحاجة
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocalazationsCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalazationsCubit, Locale>(builder: (context, locale) {
      return AdaptiveTheme(
        light: ThemeData(
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: AppColor.kPrimaryColor,
            onPrimary: AppColor.kPrimaryColor,
            secondary: AppColor.kThirtColor,
            onSecondary: AppColor.kPrimaryColor,
            error: AppColor.kRedColor,
            onError: AppColor.kRedColor,
            surface: AppColor.kWhiteColor,
            onSurface: AppColor.kBlackColor,
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              fontFamily: "SFProText-Bold",
              color: Colors.black,
            ),
            bodyMedium: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: "SFProText-Bold",
              color: Colors.black,
            ),
            bodySmall: TextStyle(fontSize: 15, color: Colors.grey),
          ),
        ),
        dark: ThemeData(
          switchTheme: const SwitchThemeData(
              thumbColor: WidgetStatePropertyAll(Colors.white)),
          colorScheme: ColorScheme(
            brightness: Brightness.dark,
            primary: AppColor.kPrimaryColor,
            onPrimary: AppColor.kThirtColorDarkMode,
            secondary: AppColor.kSecondColorDarkMode,
            onSecondary: AppColor.kSecondColorDarkMode,
            error: AppColor.kRedColor,
            onError: AppColor.kRedColor,
            surface: AppColor.kPrimaryColorDarkMode,
            onSurface: AppColor.kWhiteColor,
          ),
          iconTheme: IconThemeData(color: AppColor.kPrimaryColor),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              fontFamily: "SFProText-Bold",
              color: Colors.white,
            ),
            bodyMedium: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: "SFProText-Bold",
              color: Colors.white,
            ),
            bodySmall: TextStyle(fontSize: 15, color: Colors.grey),
          ),
        ),
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
    });
  }
}
