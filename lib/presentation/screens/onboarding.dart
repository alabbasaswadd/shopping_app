import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/core/widgets/my_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shopping_app/presentation/business_logic/cubit/products/products_cubit.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/data/model/onboarding/onboarding_model.dart';
import 'package:shopping_app/presentation/screens/auth/signup.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
  static String id = "onBoarding";
  static late int logisned;

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController(
    viewportFraction: 0.95, // لجعل جزء من الصفحة التالية مرئيًا
  );
  int _currentPage = 0;
  double _progressValue = 0.0;

  List<OnboardingModel> model = [
    OnboardingModel(
      title: "Welcome to the world of easy shopping!",
      image: "assets/images/onboarding1.gif",
      body:
          "Enjoy a convenient and fast shopping experience with the best products and special offers.",
    ),
    OnboardingModel(
      title: "Everything you need in one place!",
      image: "assets/images/onboarding2.gif",
      body:
          "Discover a wide range of products that meet all your needs, easily and from anywhere.",
    ),
    OnboardingModel(
      title: "Shop with confidence and security!",
      image: "assets/images/onboarding3.gif",
      body:
          "We guarantee you a safe shopping experience with multiple payment options and reliable delivery service.",
    ),
    OnboardingModel(
      title: "Start your shopping journey!",
      image: "assets/images/onboarding4.gif",
      body:
          "Create your account or log in to discover everything new and special.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _progressValue = (_pageController.page ?? 0) / (model.length - 1);
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    Get.offAndToNamed(SignUp.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  // شريط التقدم
                  LinearProgressIndicator(
                    value: _progressValue,
                    backgroundColor: Colors.grey[200],
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColor.kPrimaryColor),
                    minHeight: 2,
                  ),

                  // زر التخطي
                  Padding(
                    padding: const EdgeInsets.only(top: 16, right: 24),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: _completeOnboarding,
                          child: CairoText(
                            'skip'.tr,
                            color: AppColor.kPrimaryColor,
                          )),
                    ),
                  ),

                  // محتوى الصفحات مع تحسينات السحب
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: model.length,
                      physics:
                          const BouncingScrollPhysics(), // تأثير ارتداد عند النهاية
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final double scale = _currentPage == index ? 1.0 : 0.9;

                        return AnimatedBuilder(
                          animation: _pageController,
                          builder: (context, child) {
                            double value = 1.0;
                            if (_pageController.position.haveDimensions) {
                              value = _pageController.page! - index;
                              value = (1 - (value.abs() * 0.2)).clamp(0.8, 1.0);
                            }
                            return Transform.scale(
                              scale: value,
                              child: child,
                            );
                          },
                          child: OnboardingPage(
                            model: model[index],
                            isLastPage: index == model.length - 1,
                            currentPageIndex: _currentPage,
                            pageIndex: index,
                            onGetStarted: _completeOnboarding,
                          ),
                        );
                      },
                    ),
                  ),

                  // مؤشر الصفحات وأزرار التنقل
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32.0, horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // مؤشر الصفحات مع تأثير السحب
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: model.length,
                          effect: SlideEffect(
                            activeDotColor: AppColor.kPrimaryColor,
                            dotColor: Colors.grey.withOpacity(0.4),
                            dotHeight: 8,
                            dotWidth: 8,
                            spacing: 8,
                          ),
                          onDotClicked: (index) {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),

                        // زر التالي أو البدء
                        _currentPage == model.length - 1
                            ? ElevatedButton(
                                onPressed: _completeOnboarding,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  elevation: 2,
                                  shadowColor:
                                      AppColor.kPrimaryColor.withOpacity(0.3),
                                ),
                                child: CairoText(
                                  'Get Started',
                                  color: Colors.white,
                                ),
                              )
                            : FloatingActionButton(
                                onPressed: () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOutQuint,
                                  );
                                },
                                backgroundColor: AppColor.kPrimaryColor,
                                elevation: 4,
                                mini: true,
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingModel model;
  final bool isLastPage;
  final VoidCallback onGetStarted;
  final int currentPageIndex;
  final int pageIndex;

  const OnboardingPage({
    super.key,
    required this.model,
    required this.isLastPage,
    required this.onGetStarted,
    required this.currentPageIndex,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // الصورة مع تأثيرات الحركة
          if (currentPageIndex == pageIndex)
            Hero(
              tag: 'onboarding-image-${model.title}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  model.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Center(child: CircularProgressIndicator()),
            ),
          const SizedBox(height: 48),

          // العنوان مع تأثير التلاشي
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: CairoText(model.title,
                maxLines: 3, color: AppColor.kPrimaryColor, fontSize: 24),
          ),
          const SizedBox(height: 24),

          // النص الأساسي
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: CairoText(
              model.body,
              maxLines: 7,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),

          // زر البدء (يظهر فقط في الصفحة الأخيرة)
          if (isLastPage)
            AnimatedOpacity(
              opacity: isLastPage ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onGetStarted,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 4,
                  ),
                  child: CairoText(
                    'Get Started',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
