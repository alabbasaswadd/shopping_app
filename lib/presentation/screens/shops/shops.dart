import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/constants/images.dart';
import 'package:shopping_app/core/widgets/my_animation.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_card.dart';
import 'package:shopping_app/presentation/business_logic/cubit/category/category_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/category/category_state.dart';
import 'package:shopping_app/presentation/business_logic/cubit/shop/shop_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/shop/shop_state.dart';
import 'package:shopping_app/presentation/screens/category_products.dart';
import 'package:shopping_app/presentation/screens/shops/shops_products.dart';

class Shops extends StatefulWidget {
  Shops({super.key});
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
                                  print(categoryState.categories[i].name);
                                },
                                child: MyCard(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image:
                                                  AssetImage(AppImages.klogo),
                                              opacity: 0.5)),
                                      child: Center(
                                        child: Text(
                                          categoryState.categories[i].name ??
                                              "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(fontSize: 20),
                                        ),
                                      ),
                                    ),
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
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: shops.length,
                        itemBuilder: (context, index) => MyAnimation(
                          child: InkWell(
                            onTap: () {
                              Get.to(ShopProducts(
                                shopId: shops[index].id ?? "",
                              ));
                            },
                            child: MyCard(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(shops[index].firstName ?? "",
                                      style: TextStyle(fontSize: 18)),
                                ],
                              ),
                            ),
                          ),
                        ),
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
