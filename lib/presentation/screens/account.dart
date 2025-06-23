import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/constants/functions.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_text_form_field.dart';
import 'package:shopping_app/data/model/user_model.dart';
import 'package:shopping_app/presentation/business_logic/cubit/user/user_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/user/user_state.dart';
import 'package:shopping_app/presentation/screens/login.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  static String id = "edit_profile_page";

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late UserCubit cubit;
  @override
  void initState() {
    cubit = UserCubit();

    getdata();
    super.initState();
  }

  Future<void> getdata() async {
    await cubit.getUser(UserSession.id ?? ""); // تأكد من أن id موجود
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController =
      TextEditingController(text: UserSession.firstName);
  final TextEditingController _emailController =
      TextEditingController(text: UserSession.email);
  final TextEditingController _phoneController =
      TextEditingController(text: UserSession.phone);
  final TextEditingController _lastNameController =
      TextEditingController(text: UserSession.lastName);
  final TextEditingController _birthDateController =
      TextEditingController(text: UserSession.birthDate);
  final TextEditingController _genderController =
      TextEditingController(text: UserSession.gender == 0 ? "ذكر" : "أنثى");
  final TextEditingController _cityController =
      TextEditingController(text: UserSession.city);
  final TextEditingController _streetController =
      TextEditingController(text: UserSession.street);
  final TextEditingController _floorController =
      TextEditingController(text: UserSession.floor);
  final TextEditingController _apartmentController =
      TextEditingController(text: UserSession.apartment);

  // متغيرات للتحكم في تأثيرات الـ Animated Container
  bool _personalInfoExpanded = true;
  bool _addressInfoExpanded = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthDateController.dispose();
    _genderController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    _floorController.dispose();
    _apartmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("تعديل الملف الشخصي"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              _buildProfileHeader(),
              const SizedBox(height: 24),
              // Personal Information Section with Animated Container
              _buildAnimatedSection(
                title: "المعلومات الشخصية",
                expanded: _personalInfoExpanded,
                onTap: () => setState(
                    () => _personalInfoExpanded = !_personalInfoExpanded),
                child: _buildPersonalInfoSection(),
              ),
              const SizedBox(height: 16),

              // Address Information Section with Animated Container
              _buildAnimatedSection(
                title: "العنوان",
                expanded: _addressInfoExpanded,
                onTap: () => setState(
                    () => _addressInfoExpanded = !_addressInfoExpanded),
                child: _buildAddressSection(),
              ),

              // Change Password Section with Animated Container

              const SizedBox(height: 24),

              // Action Buttons
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedSection({
    required String title,
    required bool expanded,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            // Header with arrow icon
            ListTile(
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              trailing: Icon(
                expanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.grey[600],
              ),
              onTap: onTap,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),

            // Animated content
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              crossFadeState: expanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: child,
              ),
              secondChild: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColor.kPrimaryColor.withOpacity(0.2),
                      AppColor.kSecondColor.withOpacity(0.2)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://randomuser.me/api/portraits/men/1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: AppColor.kPrimaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: IconButton(
                  icon: const Icon(Icons.camera_alt,
                      size: 20, color: Colors.white),
                  onPressed: () {
                    // تغيير الصورة
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
                "${_firstNameController.text} ${_lastNameController.text}"),
          ),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            child: const Text("user@example.com"),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      children: [
        MyTextFormField(
          controller: _firstNameController,
          label: "first_name".tr,
          icon: Icons.person_outline,
          validator: (value) => value!.isEmpty ? "required_filed".tr : null,
        ),
        const SizedBox(height: 12),
        MyTextFormField(
          controller: _lastNameController,
          label: "last_name".tr,
          icon: Icons.person_outline,
          validator: (value) => value!.isEmpty ? "required_filed" : null,
        ),
        const SizedBox(height: 12),
        MyTextFormField(
          controller: _emailController,
          label: "email".tr,
          icon: Icons.email_outlined,
          readOnly: true,
        ),
        MyTextFormField(
          controller: _phoneController,
          label: "phone_number".tr,
          icon: Icons.phone_android_outlined,
          readOnly: true,
        ),
        MyTextFormField(
          controller: _birthDateController,
          label: "birth_date".tr,
          icon: Icons.calendar_today,
          onTap: () async {
            DateTime? pickedDate = await showDateDialog(context);
            _birthDateController.text = pickedDate != null
                ? "${pickedDate.toLocal()}".split(' ')[0]
                : '';
          },
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    return Column(
      children: [
        MyTextFormField(
          controller: _cityController,
          label: "city".tr,
          icon: Icons.location_city,
          validator: (value) => value!.isEmpty ? "required_filed" : null,
        ),
        const SizedBox(height: 12),
        MyTextFormField(
          controller: _streetController,
          label: "street".tr,
          icon: Icons.add_road_rounded,
          validator: (value) => value!.isEmpty ? "required_filed" : null,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: MyTextFormField(
                controller: _floorController,
                label: "floor".tr,
                icon: Icons.stairs,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: MyTextFormField(
                controller: _apartmentController,
                label: "apartment".tr,
                icon: Icons.home,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _saveProfile,
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
        const SizedBox(height: 12),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: 1.0,
          child: TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("حذف الحساب"),
                  content: const Text(
                      "هل أنت متأكد أنك تريد حذف حسابك؟ لا يمكن التراجع عن هذا الإجراء."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("إلغاء"),
                    ),
                    TextButton(
                      onPressed: () async {
                        await cubit
                            .deleteUser(UserSession.id!); // تأكد أن id موجود

                        Get.offAllNamed(
                            Login.id); // العودة إلى صفحة تسجيل الدخول
                        // حذف الحساب
                      },
                      child: const Text(
                        "حذف",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: const Text(
              "حذف الحساب",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  void _showGenderDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("اختر الجنس"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("ذكر"),
              onTap: () {
                setState(() {
                  _genderController.text = "ذكر";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("أنثى"),
              onTap: () {
                setState(() {
                  _genderController.text = "أنثى";
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // حفظ البيانات
      Get.back();
    }
  }
}
