import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_alert_dialog.dart';
import 'package:shopping_app/core/widgets/my_button.dart';
import 'package:shopping_app/core/widgets/my_list_tile.dart';
import 'package:shopping_app/core/widgets/my_text_form_field.dart';
import 'package:shopping_app/presentation/screens/login.dart';
import 'package:shopping_app/presentation/widget/settings/custom_bottom_sheet_settings.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  static String id = "settings";

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool switch_isEnable = false;
  String selectedLanguage = Get.locale?.languageCode ?? "en";

  @override
  void initState() {
    super.initState();
    _loadSwitchValue();
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
        title: Text("settings".tr),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          MyListTile(
              ontap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => CustomBottomSheetSettings(
                          textBottomSheet: "username".tr,
                          widget: SingleChildScrollView(
                            child: Column(children: [
                              MyTextFormField(label: "username".tr),
                              MyTextFormField(label: "phone_number".tr),
                              MyButton(text: "save", onPressed: () {}),
                            ]),
                          ),
                        ));
              },
              icon: Icons.person,
              title: "username".tr,
              children: const [Text("Merdan"), Icon(Icons.arrow_forward)]),
          MyListTile(
              ontap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => CustomBottomSheetSettings(
                          textBottomSheet: "phone_number".tr,
                          widget: SingleChildScrollView(
                            child: Column(children: [
                              MyTextFormField(label: "username".tr),
                              MyTextFormField(label: "phone_number".tr),
                              MyButton(text: "save", onPressed: () {}),
                            ]),
                          ),
                        ));
              },
              icon: Icons.phone_android,
              title: "phone_number".tr,
              children: const [
                Expanded(child: Text("+9635456124")),
                Icon(Icons.arrow_forward)
              ]),
          MyListTile(
              ontap: () async {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => CustomBottomSheetSettings(
                    textBottomSheet: "language".tr,
                    widget: SizedBox(
                      height: 180,
                      child: ListView(children: [
                        CustomCardSettings(
                          onChanged: (val) {},
                          widget: ListTile(
                            onTap: () async {
                              Get.updateLocale(const Locale("ar"));
                              setState(() {
                                selectedLanguage = "ar";
                              });
                              await _saveLanguage("ar");
                            },
                            leading: Text("arabic".tr),
                            trailing: Radio(
                              value: "ar",
                              groupValue: selectedLanguage,
                              onChanged: (val) async {
                                Get.updateLocale(const Locale("ar"));
                                setState(() {
                                  selectedLanguage = "ar";
                                });
                                await _saveLanguage("ar");
                              },
                            ),
                          ),
                        ),
                        CustomCardSettings(
                          onChanged: (val) {},
                          widget: ListTile(
                            onTap: () async {
                              Get.updateLocale(const Locale("en"));
                              setState(() {
                                selectedLanguage = "en";
                              });
                              await _saveLanguage("en");
                            },
                            leading: Text("english".tr),
                            trailing: Radio(
                              value: "en",
                              groupValue: selectedLanguage,
                              onChanged: (val) async {
                                Get.updateLocale(const Locale("en"));
                                setState(() {
                                  selectedLanguage = "en";
                                });
                                await _saveLanguage("en");
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
              title: "language".tr,
              children: [
                Text(selectedLanguage == "ar" ? "arabic".tr : "english".tr),
                Icon(Icons.arrow_forward)
              ]),
          MyListTile(
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
              title: "dark_mode".tr,
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
          MyListTile(
            ontap: () {
              showDialog(
                  context: context,
                  builder: (context) => MyAlertDialog(
                        content: "Do You Have Log_Out",
                        title: "Log_Out",
                        onOk: () {
                          Get.offAllNamed(Login.id);
                        },
                        onNo: () {
                          Navigator.pop(context);
                        },
                      ));
            },
            icon: Icons.logout,
            title: "log_out".tr,
            children: const [],
          )
        ],
      ),
    );
  }
}
