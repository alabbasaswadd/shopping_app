import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_text_form_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  static String id = "changePasswordScreen";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "change_password".tr, context: context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header Icon
              Icon(
                Icons.lock_reset,
                size: 80,
                color: AppColor.kPrimaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                "قم بتغيير كلمة المرور الخاصة بك",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),

              // Password Fields Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      MyTextFormField(
                        controller: _currentPasswordController,
                        label: "كلمة المرور الحالية",
                        icon: Icons.lock_outline,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "هذا الحقل مطلوب";
                          }
                          if (value.length < 6) {
                            return "يجب أن تكون 6 أحرف على الأقل";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      MyTextFormField(
                        controller: _newPasswordController,
                        label: "كلمة المرور الجديدة",
                        icon: Icons.lock_reset,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "هذا الحقل مطلوب";
                          }
                          if (value.length < 6) {
                            return "يجب أن تكون 6 أحرف على الأقل";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      MyTextFormField(
                        controller: _confirmPasswordController,
                        label: "تأكيد كلمة المرور",
                        icon: Icons.lock_reset,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "هذا الحقل مطلوب";
                          }
                          if (value != _newPasswordController.text) {
                            return "كلمات المرور غير متطابقة";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // تغيير كلمة المرور
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.kPrimaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("حفظ التغييرات"),
                ),
              ),
              const SizedBox(height: 16),

              // Forgot Password
              TextButton(
                onPressed: () {
                  // الانتقال لصفحة استعادة كلمة المرور
                },
                child: const Text(
                  "نسيت كلمة المرور؟",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
