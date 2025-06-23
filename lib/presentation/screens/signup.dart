import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/constants/functions.dart';
import 'package:shopping_app/core/widgets/my_button.dart';
import 'package:shopping_app/core/widgets/my_drop_down_button.dart';
import 'package:shopping_app/core/widgets/my_snackbar.dart';
import 'package:shopping_app/core/widgets/my_text_form_field.dart';
import 'package:shopping_app/presentation/business_logic/cubit/auth/auth_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/auth/auth_state.dart';
import 'package:shopping_app/presentation/screens/home_screen.dart';
import 'package:shopping_app/presentation/screens/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  static String id = "signUp";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController apartmentController = TextEditingController();

  int gender = 0;
  bool defaultAddress = true;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  int _currentStep = 0; // خطوة التسجيل الحالية
  late AuthCubit cubit;

  final _formKey = GlobalKey<FormState>();
  final _stepOneFormKey = GlobalKey<FormState>();
  final _stepTwoFormKey = GlobalKey<FormState>();
  final _stepThreeFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    cubit = AuthCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.25,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("SignUp".tr,
                  style: TextStyle(
                      color: Colors.white,
                      shadows: [Shadow(color: Colors.black, blurRadius: 3)])),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [
                      Color(0xff5673cc),
                      Color(0xff76c6f2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: Icon(Icons.person_add_alt_1_outlined,
                        size: 80, color: Colors.white.withOpacity(0.8)),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Stepper Indicator
                    _buildStepperIndicator(),
                    const SizedBox(height: 20),

                    // Step Content
                    if (_currentStep == 0) _buildStepOne(),
                    if (_currentStep == 1) _buildStepTwo(),
                    if (_currentStep == 2) _buildStepThree(),

                    // Navigation Buttons
                    _buildStepNavigationButtons(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepperIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepCircle(0, "المعلومات الشخصية"),
        _buildStepLine(),
        _buildStepCircle(1, "العنوان"),
        _buildStepLine(),
        _buildStepCircle(2, "الحساب"),
      ],
    );
  }

  Widget _buildStepCircle(int stepNumber, String title) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentStep >= stepNumber
                ? AppColor.kPrimaryColor
                : Colors.grey[300],
          ),
          child: Center(
            child: Text(
              "${stepNumber + 1}",
              style: TextStyle(
                color: _currentStep >= stepNumber ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            color: _currentStep >= stepNumber
                ? AppColor.kPrimaryColor
                : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine() {
    return Container(
      width: 50,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      color: Colors.grey[300],
    );
  }

  Widget _buildStepOne() {
    return Form(
      key: _stepOneFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Personal Info Section
          buildSectionHeader("personal_info".tr),
          const SizedBox(height: 10),

          // Name Row
          Row(
            children: [
              Expanded(
                child: MyTextFormField(
                    controller: firstNameController,
                    label: "first_name".tr,
                    icon: Icons.person_outline,
                    validator: (value) =>
                        value!.isEmpty ? 'required_filed'.tr : null),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: MyTextFormField(
                  controller: lastNameController,
                  label: "last_name".tr,
                  icon: Icons.person_outline,
                  validator: (value) =>
                      value!.isEmpty ? 'required_filed'.tr : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Birth Date and Gender
          Row(
            children: [
              Expanded(
                flex: 1,
                child: MyTextFormField(
                  controller: birthDateController,
                  label: "birth_date".tr,
                  icon: Icons.calendar_today,
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDateDialog(context);
                    if (pickedDate != null) {
                      String formattedDate =
                          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                      birthDateController.text = formattedDate;
                    }
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'required_filed'.tr : null,
                ),
              ),
              Expanded(
                flex: 1,
                child: CustomDropdown<int>(
                  value: gender,
                  hintText: 'select_gender'.tr,
                  prefixIcon: Icons.transgender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                  items: [
                    DropdownMenuItem<int>(
                      value: 0,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.male,
                                color: Colors.blue[700], size: 20),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "male".tr,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.pink.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.female,
                                color: Colors.pink[700], size: 20),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "female".tr,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          MyTextFormField(
            controller: phoneController,
            label: "phone".tr,
            icon: Icons.phone_android,
            keyboardType: TextInputType.phone,
            validator: (value) => value!.isEmpty ? 'required_filed'.tr : null,
          ),
          _buildLoginLink(),
          const SizedBox(height: 10),
          _buildGuestOption(),
        ],
      ),
    );
  }

  Widget _buildStepTwo() {
    return Form(
      key: _stepTwoFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Address Section
          buildSectionHeader("address_info".tr),
          const SizedBox(height: 20),

          MyTextFormField(
            controller: cityController,
            label: "city".tr,
            icon: Icons.location_city,
            validator: (value) => value!.isEmpty ? 'required_filed'.tr : null,
          ),
          const SizedBox(height: 15),

          MyTextFormField(
            controller: streetController,
            label: "street".tr,
            icon: Icons.streetview,
            validator: (value) => value!.isEmpty ? 'required_filed'.tr : null,
          ),
          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: MyTextFormField(
                  controller: floorController,
                  label: "floor".tr,
                  icon: Icons.meeting_room,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'required_filed'.tr : null,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: MyTextFormField(
                  controller: apartmentController,
                  label: "apartment".tr,
                  icon: Icons.home_outlined,
                  validator: (value) =>
                      value!.isEmpty ? 'required_filed'.tr : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepThree() {
    return Form(
      key: _stepThreeFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Account Info Section
          buildSectionHeader("account_info".tr),
          const SizedBox(height: 20),

          MyTextFormField(
            controller: emailController,
            label: "email".tr,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => value!.isEmpty || !value.contains('@')
                ? 'required_filed'.tr
                : null,
          ),
          const SizedBox(height: 15),

          MyTextFormField(
            controller: passwordController,
            label: "password".tr,
            icon: Icons.lock_outline,
            obscureText: _obscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يجب إدخال كلمة المرور';
              }
              if (value.length < 8) {
                return 'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل';
              }
              if (!value.contains(RegExp(r'[0-9]'))) {
                return 'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل';
              }
              if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>\\$]'))) {
                return 'يجب أن تحتوي كلمة المرور على رمز خاص واحد على الأقل (!@#...)';
              }
              return null;
            },
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          const SizedBox(height: 15),

          MyTextFormField(
            controller: confirmPasswordController,
            label: "confirm_password".tr,
            icon: Icons.lock_outline,
            obscureText: _obscureConfirmPassword,
            validator: (value) => value != passwordController.text
                ? 'كلمة المرور غير متطابقة'.tr
                : null,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () => setState(
                  () => _obscureConfirmPassword = !_obscureConfirmPassword),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepNavigationButtons() {
    return Column(
      children: [
        const SizedBox(height: 30),
        if (_currentStep == 0)
          MyButton(
            text: "next".tr,
            onPressed: () {
              if (_stepOneFormKey.currentState!.validate()) {
                setState(() {
                  _currentStep = 1;
                });
              }
            },
          )
        else if (_currentStep == 1)
          Row(
            children: [
              Expanded(
                child: MyButton(
                    color: AppColor.kThirtColor,
                    textColor: AppColor.kPrimaryColor,
                    text: "back".tr,
                    onPressed: () {
                      setState(() {
                        _currentStep = 0;
                      });
                    }),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: MyButton(
                  text: "next".tr,
                  onPressed: () {
                    if (_stepTwoFormKey.currentState!.validate()) {
                      setState(() {
                        _currentStep = 2;
                      });
                    }
                  },
                ),
              ),
            ],
          )
        else
          BlocConsumer<AuthCubit, AuthState>(
            bloc: cubit,
            listener: (context, state) {
              if (state is AuthSignUpSuccess) {
                Get.offAllNamed(HomeScreen.id);
              } else if (state is AuthError) {
                MySnackbar.showError(context, state.message);
              }
            },
            builder: (context, state) {
              bool isLoading = false;
              if (state is AuthLoading) {
                isLoading = true;
              }
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: MyButton(
                            color: AppColor.kThirtColor,
                            textColor: AppColor.kPrimaryColor,
                            text: "back".tr,
                            onPressed: () {
                              setState(() {
                                _currentStep = 1;
                              });
                            }),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: MyButton(
                          isLoading: isLoading,
                          text: "SignUp".tr,
                          onPressed: () {
                            if (_stepThreeFormKey.currentState!.validate()) {
                              cubit.signup(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                birthDate: birthDateController.text,
                                gender: gender,
                                email: emailController.text,
                                phone: phoneController.text,
                                password: passwordController.text,
                                city: cityController.text,
                                street: streetController.text,
                                floor: floorController.text,
                                apartment: apartmentController.text,
                                defaultAddress: defaultAddress,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
      ],
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("do_you_have_an_account ? ".tr,
            style: TextStyle(color: Colors.grey[600])),
        const SizedBox(width: 5),
        InkWell(
          onTap: () => Get.offAndToNamed(Login.id),
          child: Text("login".tr,
              style: TextStyle(
                  color: AppColor.kPrimaryColor, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  Widget _buildGuestOption() {
    return Center(
      child: InkWell(
        onTap: () => Get.offAllNamed(HomeScreen.id),
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.grey[600]),
            children: [
              TextSpan(text: "browse_no_account_part1".tr),
              TextSpan(
                text: "browse_no_account_part2".tr,
                style: TextStyle(
                  color: AppColor.kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColor.kPrimaryColor,
      ),
    );
  }
}
