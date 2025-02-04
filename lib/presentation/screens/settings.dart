// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously

import 'dart:convert';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/business_logic/cubit/localazations/localazations_cubit.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/presentation/screens/login.dart';
import 'package:shopping_app/presentation/widget/settings/custom_alert_dialog_settings.dart';
import 'package:shopping_app/presentation/widget/settings/custom_bottom_sheet_settings.dart';
import 'package:shopping_app/presentation/widget/settings/custom_listtile_settings.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  static String id = "settings";

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // ignore: non_constant_identifier_names
  bool switch_isEnable = false;
  String selectedLanguage = "en";
  Map<String, String> translations = {};
  @override
  void initState() {
    super.initState();
    _loadSwitchValue();
    _loadLanguage();
  }

  Future<void> _loadSwitchValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      switch_isEnable = prefs.getBool('theme') ?? false;

      if (switch_isEnable) {
        AdaptiveTheme.of(context).setDark();
      } else {
        AdaptiveTheme.of(context).setLight();
      }
    });
  }

  Future<void> _saveSwitchValue(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('theme', value);
  }

  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString('language') ?? 'en';
      _loadTranslations(selectedLanguage); // تحميل الترجمات بناءً على اللغة
      context.read<LocalazationsCubit>().changeLang(selectedLanguage);
    });
  }

  Future<void> _saveLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }

  Future<void> _loadTranslations(String languageCode) async {
    String jsonString =
        await rootBundle.loadString('assets/localazations/$languageCode.json');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    setState(() {
      translations = Map<String, String>.from(jsonMap);
    });
  }

  String getTranslation(String key) {
    return translations[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        shadowColor: Colors.black,
        title: Text(getTranslation('settings_title')),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: CustomListtileSettings(
                ontap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => CustomBottomSheetSettings(
                            textBottomSheet: getTranslation('username'),
                            widget: SingleChildScrollView(
                              child: Column(children: [
                                CustomTextFieldSettings(
                                    label: getTranslation('username')),
                                CustomTextFieldSettings(
                                    label: getTranslation('phone_number')),
                                CustomButtonSettings(),
                              ]),
                            ),
                          ));
                },
                icon: Icons.person,
                title: getTranslation('username'),
                children: const [Text("Merdan"), Icon(Icons.arrow_forward)]),
          ),
          CustomListtileSettings(
              ontap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => CustomBottomSheetSettings(
                          textBottomSheet: getTranslation('phone_number'),
                          widget: SingleChildScrollView(
                            child: Column(children: [
                              CustomTextFieldSettings(
                                  label: getTranslation('username')),
                              CustomTextFieldSettings(
                                  label: getTranslation('phone_number')),
                              CustomButtonSettings(),
                            ]),
                          ),
                        ));
              },
              icon: Icons.phone_android,
              title: getTranslation('phone_number'),
              children: const [
                Expanded(child: Text("+9635456124")),
                Icon(Icons.arrow_forward)
              ]),
          CustomListtileSettings(
              ontap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => CustomBottomSheetSettings(
                    textBottomSheet: getTranslation('language'),
                    widget: Container(
                      height: 180,
                      child: ListView(children: [
                        CustomCardSettings(
                          onChanged: (val) {},
                          widget: ListTile(
                            onTap: () async {
                              setState(() {
                                selectedLanguage = "ar";
                              });
                              await _saveLanguage("ar");
                              _loadTranslations("ar");
                              context
                                  .read<LocalazationsCubit>()
                                  .changeLang("ar");
                            },
                            leading: Text(getTranslation('arabic')),
                            trailing: Radio(
                              value: "ar",
                              groupValue: selectedLanguage,
                              onChanged: (val) async {
                                setState(() {
                                  selectedLanguage = "ar";
                                });
                                await _saveLanguage("ar");
                                _loadTranslations("ar");
                                context
                                    .read<LocalazationsCubit>()
                                    .changeLang("ar");
                              },
                            ),
                          ),
                        ),
                        CustomCardSettings(
                          onChanged: (val) {},
                          widget: ListTile(
                            onTap: () async {
                              setState(() {
                                selectedLanguage = "en";
                              });
                              await _saveLanguage("en");
                              _loadTranslations("en");
                              context
                                  .read<LocalazationsCubit>()
                                  .changeLang("en");
                            },
                            leading: Text(getTranslation('english')),
                            trailing: Radio(
                              value: "en",
                              groupValue: selectedLanguage,
                              onChanged: (val) async {
                                setState(() {
                                  selectedLanguage = "en";
                                });
                                await _saveLanguage("en");
                                _loadTranslations("en");
                                context
                                    .read<LocalazationsCubit>()
                                    .changeLang("en");
                              },
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                );
              },
              icon: Icons.language,
              title: getTranslation('language'),
              children: [
                Text(selectedLanguage == "ar"
                    ? getTranslation('arabic')
                    : getTranslation('english')),
                Icon(Icons.arrow_forward)
              ]),
          CustomListtileSettings(
              ontap: () async {
                setState(() {
                  switch_isEnable = !switch_isEnable;
                  _saveSwitchValue(switch_isEnable);

                  if (switch_isEnable) {
                    AdaptiveTheme.of(context).setDark();
                  } else {
                    AdaptiveTheme.of(context).setLight();
                  }
                });
              },
              icon: Icons.dark_mode,
              title: getTranslation('dark_mode'),
              children: [
                Switch(
                    thumbColor: switch_isEnable
                        ? WidgetStateProperty.all(AppColor.kWhiteColor)
                        : WidgetStateProperty.all(AppColor.kSecondColor),
                    value: switch_isEnable,
                    onChanged: (val) async {
                      setState(() {
                        switch_isEnable = val;
                        _saveSwitchValue(val);
                        if (switch_isEnable) {
                          AdaptiveTheme.of(context).setDark();
                        } else {
                          AdaptiveTheme.of(context).setLight();
                        }
                      });
                    })
              ]),
          CustomListtileSettings(
            ontap: () {
              showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialogSettings(
                        onOk: () {
                          Get.offAllNamed(Login.id);
                        },
                        onNo: () {
                          Navigator.pop(context);
                        },
                      ));
            },
            icon: Icons.logout,
            title: getTranslation('log_out'),
            children: const [],
          )
        ],
      ),
    );
  }
}
