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

  // Controllers بدون تمرير قيم أولية
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _birthDateController;
  late TextEditingController _genderController;
  late TextEditingController _cityController;
  late TextEditingController _streetController;
  late TextEditingController _floorController;
  late TextEditingController _apartmentController;

  bool _personalInfoExpanded = true;
  bool _addressInfoExpanded = true;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    cubit = UserCubit();

    // تهيئة الكنترولرز بدون قيمة مبدئية
    loadData();
  }

  void loadData() async {
    await UserSession.init(); // تحميل بيانات المستخدم وتخزينها في _user
    // تهيئة الكنترولرز بدون قيمة مبدئية
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _birthDateController = TextEditingController();
    _genderController = TextEditingController();
    _cityController = TextEditingController();
    _streetController = TextEditingController();
    _floorController = TextEditingController();
    _apartmentController = TextEditingController();
    setState(() {});
    // جلب بيانات المستخدم حسب الـ id من الـ UserSession
    final userId = UserSession.id;
    if (userId != null && userId.isNotEmpty) {
      cubit.getUser(userId);
    } else {
      // مثلا توجه لتسجيل الدخول لو ما في id
      print("لا يوجد معرف مستخدم");
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    _genderController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    _floorController.dispose();
    _apartmentController.dispose();
    super.dispose();
  }

  // دالة لتحديث الكنترولرز حسب بيانات المستخدم
  void _updateControllers(UserModel user) {
    _firstNameController.text = user.firstName ?? "";
    _lastNameController.text = user.lastName ?? "";
    _emailController.text = user.email?.userName ?? "";
    _phoneController.text = user.phone ?? "";
    _birthDateController.text = user.birthDate ?? "";
    _genderController.text = (user.gender == 0) ? "ذكر" : "أنثى";
    _cityController.text = user.address?.city ?? "";
    _streetController.text = user.address?.street ?? "";
    _floorController.text = user.address?.floor ?? "";
    _apartmentController.text = user.address?.apartment ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubit,
      child: Scaffold(
        appBar: myAppBar("تعديل الملف الشخصي",context),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              // حدث الكنترولرز عند جلب البيانات
              _updateControllers(state.user);

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileHeader(),
                      const SizedBox(height: 24),
                      _buildAnimatedSection(
                        title: "المعلومات الشخصية",
                        expanded: _personalInfoExpanded,
                        onTap: () => setState(() =>
                            _personalInfoExpanded = !_personalInfoExpanded),
                        child: _buildPersonalInfoSection(),
                      ),
                      const SizedBox(height: 16),
                      _buildAnimatedSection(
                        title: "العنوان",
                        expanded: _addressInfoExpanded,
                        onTap: () => setState(
                            () => _addressInfoExpanded = !_addressInfoExpanded),
                        child: _buildAddressSection(),
                      ),
                      const SizedBox(height: 24),
                      _buildActionButtons(),
                    ],
                  ),
                ),
              );
            } else if (state is UserError) {
              return Center(child: Text("حدث خطأ: ${state.message}"));
            }
            // الحالة الافتراضية قبل تحميل البيانات
            return const Center(child: Text("يرجى الانتظار..."));
          },
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
            child: Text(_emailController.text),
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
            onPressed: () async {
              final updatedUser = UserModel(
                id: UserSession.id,
                firstName: _firstNameController.text,
                lastName: _lastNameController.text,
                phone: _phoneController.text,
                birthDate: _birthDateController.text,
                gender: _genderController.text == "ذكر" ? 0 : 1,
                address: AddressModel(
                  city: _cityController.text,
                  street: _streetController.text,
                  floor: _floorController.text,
                  apartment: _apartmentController.text,
                  defaultAddress: true,
                ),
                email: UserSession.user?.email,
                password: '', // لا تغيّره لأنك ما عدّلته
              );

              // await cubit.updateUser(UserSession.id!, updatedUser);
              // await UserSession.updateUser(
              //     updatedUser); // 👈 لتحديث الجلسة أيضًا
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
                        await cubit.deleteUser(UserSession.id!); // ✅
                        await UserSession.clear(); // 🧹 حذف بيانات الجلسة
                        Get.offAllNamed(Login.id); // 🔁 العودة لصفحة الدخول
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
