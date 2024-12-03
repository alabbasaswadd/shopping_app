import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/business_logic/cubit/localazations/localazations_cubit.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/translations.dart';
import 'package:shopping_app/view/widget/settings/custom_alert_dialog_settings.dart';
import 'package:shopping_app/view/widget/settings/custom_bottom_sheet_settings.dart';
import 'package:shopping_app/view/widget/settings/custom_listtile_settings.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  static String id = "settings";

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool switch_isEnable = false;
  String selectedLanguage = "en"; // متغير لتحديد اللغة الحالية

  @override
  void initState() {
    super.initState();
    _loadSwitchValue(); // تحميل قيمة الوضع الليلي
    _loadLanguage(); // تحميل اللغة المحفوظة
  }

  /// تحميل الثيم (وضع ليلي/نهاري) من SharedPreferences
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

  /// حفظ قيمة الثيم (وضع ليلي/نهاري) في SharedPreferences
  Future<void> _saveSwitchValue(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('theme', value);
  }

  /// تحميل اللغة المحفوظة من SharedPreferences
  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString('language') ?? 'en';
      context.read<LocalazationsCubit>().changeLang(selectedLanguage);
    });
  }

  /// حفظ اللغة المحددة في SharedPreferences
  Future<void> _saveLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        shadowColor: Colors.black,
        title: Text("Settings"),
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
                            textBottomSheet: "Username",
                            widget: Column(children: [
                              CustomTextFieldSettings(label: "Username"),
                              CustomTextFieldSettings(label: "Phone Number"),
                              CustomButtonSettings(),
                            ]),
                          ));
                },
                icon: Icons.person,
                title: "Username",
                children: [Text("Merdan"), Icon(Icons.arrow_forward)]),
          ),
          CustomListtileSettings(
              ontap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => CustomBottomSheetSettings(
                          textBottomSheet: "Phone Number",
                          widget: Column(children: [
                            CustomTextFieldSettings(label: "Username"),
                            CustomTextFieldSettings(label: "Phone Number"),
                            CustomButtonSettings(),
                          ]),
                        ));
              },
              icon: Icons.phone_android,
              title: "Phone Number",
              children: [
                Expanded(child: Text("+9635456124")),
                Icon(Icons.arrow_forward)
              ]),
          CustomListtileSettings(
              ontap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => CustomBottomSheetSettings(
                    textBottomSheet: "Language",
                    widget: Container(
                      height: 150,
                      child: ListView(children: [
                        CustomCardSettings(
                          onChanged: (val) {},
                          widget: ListTile(
                            onTap: () async {
                              setState(() {
                                selectedLanguage = "ar";
                              });
                              await _saveLanguage("ar");
                              context
                                  .read<LocalazationsCubit>()
                                  .changeLang("ar");
                            },
                            leading: Text("Arabic"),
                            trailing: Radio(
                              value: "ar",
                              groupValue: selectedLanguage,
                              onChanged: (val) async {
                                setState(() {
                                  selectedLanguage = "ar";
                                });
                                await _saveLanguage("ar");
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
                              context
                                  .read<LocalazationsCubit>()
                                  .changeLang("en");
                            },
                            leading: Text("English"),
                            trailing: Radio(
                              value: "en",
                              groupValue: selectedLanguage,
                              onChanged: (val) async {
                                await MyI18n
                                    .loadTranslations(); // تغيير إلى الإنجليزية
                                setState(() {});
                                await _saveLanguage("en");
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
              title: "Language",
              children: [
                Text(selectedLanguage == "ar" ? "Arabic" : "English"),
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
              title: "Dark Mode",
              children: [
                Switch(
                    thumbColor: switch_isEnable
                        ? WidgetStatePropertyAll(AppColor.kWhiteColor)
                        : WidgetStatePropertyAll(AppColor.kSecondColor),
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
                        onOk: () {},
                        onNo: () {
                          Navigator.pop(context);
                        },
                      ));
            },
            icon: Icons.logout,
            title: "Log Out".i18n,
            children: [],
          )
        ],
      ),
    );
  }
}
