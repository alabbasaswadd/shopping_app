import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_button.dart';
import 'package:shopping_app/core/widgets/my_snackbar.dart';
import 'package:shopping_app/core/widgets/my_text_form_field.dart';
import 'package:shopping_app/presentation/business_logic/cubit/auth/auth_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/auth/auth_state.dart';
import 'package:shopping_app/presentation/screens/home_screen.dart';
import 'package:shopping_app/presentation/screens/auth/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static String id = "login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _rememberMe = false;
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AuthCubit cubit;

  final _formKey = GlobalKey<FormState>();

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
              title: Text("login".tr,
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
                    child: Icon(Icons.login,
                        size: 80, color: Colors.white.withOpacity(0.8)),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Center(
                      child: Column(
                        children: [
                          Text("Welcome_Back".tr,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColor.kPrimaryColor,
                              )),
                          SizedBox(height: 8),
                          Text("welcome_message".tr,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[600],
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),

                    MyTextFormField(
                      icon: Icons.email,
                      label: "email".tr,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value!.isEmpty || !value.contains('@')
                              ? 'required_filed'.tr
                              : null,
                    ),
                    const SizedBox(height: 20),
                    MyTextFormField(
                      icon: Icons.lock,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                      ),
                      label: "password".tr,
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      validator: (value) =>
                          value!.length < 6 ? 'password_too_short'.tr : null,
                    ),

                    // Remember Me & Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            // TODO: Implement forgot password
                          },
                          child: Text("forgot_password".tr,
                              style: TextStyle(color: AppColor.kPrimaryColor)),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),

                    // Login Button
                    BlocConsumer<AuthCubit, AuthState>(
                      bloc: cubit,
                      listener: (context, state) {
                        if (state is AuthAuthenticated) {
                          Get.offAllNamed(HomeScreen.id);
                        } else if (state is AuthError) {
                          MySnackbar.showError(context, state.message);
                        }
                      },
                      builder: (context, state) {
                        var isLoading = false;
                        if (state is AuthLoading) {
                          isLoading = true;
                        }
                        return MyButton(
                          isLoading: isLoading,
                          text: "login".tr,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.login(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: 25),

                    // Sign Up Link
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("dont_have_an_account".tr,
                              style: TextStyle(color: Colors.grey[600])),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () => Get.offAndToNamed(SignUp.id),
                            child: Text("SignUp".tr,
                                style: TextStyle(
                                    color: AppColor.kPrimaryColor,
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade400)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text("or".tr,
                              style: TextStyle(color: Colors.grey.shade600)),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade400)),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Guest Option
                    Center(
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
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
