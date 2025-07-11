import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_alert_dialog.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_text_form_field.dart';
import 'package:shopping_app/presentation/screens/auth/login.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  static String id = "settings";

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isDarkMode = false;
  String _selectedLanguage = Get.locale?.languageCode ?? "en";
  String _phoneNumber = "+9635456124";

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('theme') ?? false;
      _selectedLanguage = prefs.getString('language') ?? "en";

      _phoneNumber = prefs.getString('phone') ?? "+9635456124";
    });
  }

  Future<void> _saveSetting<T>(String key, T value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
  }

  void _showEditDialog(
      {required String title,
      required String initialValue,
      required ValueChanged<String> onSave}) {
    final controller = TextEditingController(text: initialValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: MyTextFormField(
          controller: controller,
          label: title,
          icon: null,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("cancel".tr),
          ),
          ElevatedButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.kPrimaryColor,
            ),
            child: Text("save".tr),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "settings".tr, context: context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Account Settings Section
            _buildSectionHeader("account_settings".tr),
            _buildSettingTile(
              icon: Icons.person_outline,
              title: "username".tr,
              onTap: () => _showEditDialog(
                title: "username".tr,
                initialValue: "aa",
                onSave: (value) async {},
              ),
            ),
            _buildSettingTile(
              icon: Icons.phone_android_outlined,
              title: "phone_number".tr,
              value: _phoneNumber,
              onTap: () => _showEditDialog(
                title: "phone_number".tr,
                initialValue: _phoneNumber,
                onSave: (value) async {
                  await _saveSetting('phone', value);
                  setState(() => _phoneNumber = value);
                },
              ),
            ),
            const SizedBox(height: 24),

            // App Settings Section
            _buildSectionHeader("app_settings".tr),
            _buildSettingTile(
              icon: Icons.language_outlined,
              title: "language".tr,
              value: _selectedLanguage == "ar" ? "arabic".tr : "english".tr,
              onTap: () => _showLanguageBottomSheet(),
            ),
            _buildSettingTile(
              onTap: () {},
              icon: Icons.dark_mode_outlined,
              title: "dark_mode".tr,
              trailing: Switch(
                value: _isDarkMode,
                onChanged: (value) async {
                  await _saveSetting('theme', value);
                  setState(() => _isDarkMode = value);
                  if (value) {
                    AdaptiveTheme.of(context).setDark();
                  } else {
                    AdaptiveTheme.of(context).setLight();
                  }
                },
                activeColor: AppColor.kPrimaryColor,
              ),
            ),
            const SizedBox(height: 24),

            // Actions Section
            _buildSectionHeader("actions".tr),
            _buildSettingTile(
              icon: Icons.logout_outlined,
              title: "log_out".tr,
              color: Colors.red,
              onTap: () => _showLogoutDialog(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? value,
    Widget? trailing,
    Color? color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
      ),
      child: ListTile(
        leading: Icon(icon, color: color ?? AppColor.kPrimaryColor),
        title: Text(title),
        subtitle: value != null ? Text(value) : null,
        trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "select_language".tr,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            RadioListTile(
              title: Text("arabic".tr),
              value: "ar",
              groupValue: _selectedLanguage,
              onChanged: (value) async {
                await _saveSetting('language', "ar");
                Get.updateLocale(const Locale("ar"));
                setState(() => _selectedLanguage = "ar");
                Navigator.pop(context);
              },
              activeColor: AppColor.kPrimaryColor,
            ),
            RadioListTile(
              title: Text("english".tr),
              value: "en",
              groupValue: _selectedLanguage,
              onChanged: (value) async {
                await _saveSetting('language', "en");
                Get.updateLocale(const Locale("en"));
                setState(() => _selectedLanguage = "en");
                Navigator.pop(context);
              },
              activeColor: AppColor.kPrimaryColor,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => MyAlertDialog(
        title: "log_out".tr,
        content: "do_you_want_to_log_out".tr,
        onOk: () => Get.offAllNamed(Login.id),
        onNo: () => Navigator.pop(context),
      ),
    );
  }
}
