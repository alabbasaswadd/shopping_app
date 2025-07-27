import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/cached/cached_image.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_animation.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_card.dart';
import 'package:shopping_app/core/widgets/my_text.dart';
import 'package:shopping_app/presentation/business_logic/cubit/category/category_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/category/category_state.dart';
import 'package:shopping_app/presentation/business_logic/cubit/shop/shop_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/shop/shop_state.dart';
import 'package:shopping_app/presentation/screens/category_products.dart';
import 'package:shopping_app/presentation/screens/shops/shops_products.dart';

class Shops extends StatefulWidget {
  const Shops({super.key});
  static String id = "stores";

  @override
  State<Shops> createState() => _ShopsState();
}

class _ShopsState extends State<Shops> {
  late ShopCubit cubit;
  late CategoryCubit categoryCubit;

  @override
  void initState() {
    super.initState();
    cubit = ShopCubit();
    categoryCubit = CategoryCubit();
    cubit.getShops();
    categoryCubit.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: myAppBar(title: "stores".tr, context: context),
      body: BlocBuilder<ShopCubit, ShopState>(
        bloc: cubit,
        builder: (context, shopState) {
          if (shopState is ShopLoading) {
            return Center(
              child: SpinKitChasingDots(color: AppColor.kPrimaryColor),
            );
          } else if (shopState is ShopLoaded) {
            var shops = shopState.shops;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ الفئات بدون height ثابت
                  BlocBuilder<CategoryCubit, CategoryState>(
                    bloc: categoryCubit,
                    builder: (context, categoryState) {
                      if (categoryState is CategoryLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (categoryState is CategoryLoaded &&
                          categoryState.categories.isNotEmpty) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 50,
                            maxHeight: size.height * 0.2, // مرن حسب حجم الشاشة
                          ),
                          child: ListView.builder(
                            itemExtent: 150,
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryState.categories.length,
                            itemBuilder: (context, i) => MyAnimation(
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => CategoryProducts(
                                      categoryName:
                                          categoryState.categories[i].name ??
                                              ""));
                                },
                                child: MyCard(
                                  padding: EdgeInsets.zero,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      // الصورة في الخلفية
                                      Positioned.fill(
                                        child: CachedImageWidget(
                                          heightRatio: 178,
                                          widthRatio: 200,
                                          imageUrl: categoryState
                                                  .categories[i].image ??
                                              "",
                                          memCacheHeight: (0.25.sh).toInt(),
                                          memCacheWidth: (0.25.sh).toInt(),
                                        ),
                                      ),

                                      // النص في المنتصف فوق الصورة
                                      Center(
                                        child: CairoText(
                                          categoryState.categories[i].name ??
                                              "",
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Text("لا توجد تصنيفات");
                      }
                    },
                  ),

                  const SizedBox(height: 24),

                  // ✅ شبكة المتاجر بدون أبعاد ثابتة
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = size.width > 900
                          ? 4
                          : size.width > 600
                              ? 3
                              : 2;

                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 1.2, // اضبط حسب الشكل المطلوب
                        ),
                        itemCount: shops.length,
                        itemBuilder: (context, index) {
                          final shop = shops[index];
                          return MyAnimation(
                            child: InkWell(
                              onTap: () {
                                Get.to(ShopProducts(
                                  shopId: shop.id ?? "",
                                ));
                              },
                              child: MyCard(
                                padding: EdgeInsets.zero,
                                borderRadius: BorderRadius.circular(16.r),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned.fill(
                                      child: CachedImageWidget(
                                        heightRatio: double.infinity,
                                        widthRatio: double.infinity,
                                        imageUrl: "",
                                        memCacheHeight: (0.25.sh).toInt(),
                                        memCacheWidth: (0.25.sw).toInt(),
                                        // يمكنك تعديل الصورة حسب الحاجة
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black
                                            .withOpacity(0.3), // تظليل للصورة
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                      ),
                                    ),
                                    Center(
                                      child: CairoText(
                                        shop.firstName ?? "",
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (shopState is ShopError) {
            return Center(child: Text(shopState.error));
          } else {
            return Center(child: Text("حدث خطأ غير متوقع"));
          }
        },
      ),
    );
  }
}
