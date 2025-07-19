import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_animation.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_button.dart';
import 'package:shopping_app/core/widgets/my_text.dart';
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
              CairoText(
                "قم بتغيير كلمة المرور الخاصة بك",
                color: Colors.grey[600],
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
              MyAnimation(
                child: MyButton(
                  text: "حفظ التغييرات",
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 16),

              // Forgot Password
              MyAnimation(
                scale: 0.85,
                child: TextButton(
                  onPressed: () {
                    // الانتقال لصفحة استعادة كلمة المرور
                  },
                  child: CairoText(
                    "نسيت كلمة المرور؟",
                    color: AppColor.kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
