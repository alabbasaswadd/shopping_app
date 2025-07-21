import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/cached/cached_image.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_animation.dart';
import 'package:shopping_app/core/widgets/my_card.dart';
import 'package:shopping_app/core/widgets/my_text.dart';
import 'package:shopping_app/data/model/products/product_data_model.dart';
import 'package:shopping_app/presentation/business_logic/cubit/products/products_cubit.dart';
import 'package:shopping_app/presentation/screens/home_screen.dart';
import 'package:shopping_app/presentation/screens/products/product_details.dart';

class ProductsDetailsBody extends StatefulWidget {
  const ProductsDetailsBody({super.key, required this.product});
  final ProductDataModel product;

  @override
  State<ProductsDetailsBody> createState() => _ProductsDetailsBodyState();
}

class _ProductsDetailsBodyState extends State<ProductsDetailsBody> {
  late ProductsCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = ProductsCubit();
    cubit.getProducts(
      excludeId: widget.product.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: [
              CachedImageWidget(
                imageUrl: widget.product.image ?? "",
                heightRatio: 100,
                widthRatio: 100,
              )
            ],
            options: CarouselOptions(
              autoPlayInterval: const Duration(seconds: 2),
              autoPlay: true,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: CairoText(widget.product.name ?? "")),
                    CairoText(
                      "${widget.product.price}\$",
                      fontSize: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CairoText(
                  widget.product.description ?? "",
                  maxLines: 100,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),

          /// ✅ قسم المنتجات المشابهة
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: CairoText(
              "منتجات مشابهة",
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<ProductsCubit, ProductsState>(
            bloc: cubit,
            builder: (context, state) {
              if (state is ProductsLoaded) {
                final similarProducts = state.products
                    .where((p) =>
                        p.category?.name == widget.product.category?.name)
                    .toList();

                if (similarProducts.isEmpty) {
                  return Center(
                      child: CairoText(
                    "لا توجد منتجات مشابهة",
                    color: AppColor.kPrimaryColor,
                  ));
                }
                return SizedBox(
                  height: 0.43.sh,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: similarProducts.length,
                    itemBuilder: (context, i) {
                      final product = similarProducts[i];
                      return MyAnimation(
                        child: GestureDetector(
                          onTap: () {
                            Get.offNamedUntil(
                              ProductDetails.id,
                              ModalRoute.withName(HomeScreen.id),
                              arguments: product,
                            );
                          },
                          child: Container(
                            width: 0.43
                                .sw, // 👈 ثبات العرض لكل منتج (نصف الشاشة تقريبًا)
                            margin: const EdgeInsets.all(7),
                            child: MyCard(
                              padding: EdgeInsets.zero,
                              elevation: 6,
                              borderRadius: BorderRadius.circular(16.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // صورة المنتج
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.r),
                                    ),
                                    child: CachedImageWidget(
                                      heightRatio: 178,
                                      widthRatio: 200,
                                      imageUrl: product.image ?? "",
                                      memCacheHeight: (0.25.sh).toInt(),
                                      memCacheWidth: (0.25.sh).toInt(),
                                    ),
                                  ),

                                  // نصوص: الاسم والوصف
                                  Padding(
                                    padding: EdgeInsets.all(6.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // اسم المنتج
                                        CairoText(
                                          product.name ?? "",
                                          fontSize: 11.sp,
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 12.h),

                                        // وصف المنتج
                                        CairoText(
                                          product.description ?? "",
                                          fontSize: 10.sp,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.6),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const Spacer(),

                                  // السعر
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 12, left: 15, right: 15),
                                    child: CairoText(
                                      textAlign: TextAlign.end,
                                      "${product.price}\$",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is ProductsLoading) {
                return SpinKitChasingDots(color: AppColor.kPrimaryColor);
              } else {
                return CairoText("حدث خطأ أثناء تحميل المنتجات المشابهة");
              }
            },
          ),

          const SizedBox(height: 30),

          /// ✅ قسم عرض كل المنتجات في GridView
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: CairoText(
              "جميع المنتجات",
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<ProductsCubit, ProductsState>(
            bloc: cubit,
            builder: (context, state) {
              if (state is ProductsLoading) {
                return Center(
                  child: SpinKitChasingDots(color: AppColor.kPrimaryColor),
                );
              } else if (state is ProductsLoaded) {
                final allProducts = state.products;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: allProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65.sh / 1000,
                  ),
                  itemBuilder: (context, i) {
                    final product = allProducts[i];
                    return MyAnimation(
                      child: GestureDetector(
                        onTap: () {
                          Get.offNamedUntil(
                            ProductDetails.id,
                            ModalRoute.withName(HomeScreen.id),
                            arguments: product,
                          );
                        },
                        child: MyCard(
                          margin: const EdgeInsets.all(7),
                          padding: EdgeInsets.zero,
                          elevation: 6,
                          borderRadius: BorderRadius.circular(16.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.r),
                                ),
                                child: CachedImageWidget(
                                  heightRatio: 178,
                                  widthRatio: 200,
                                  imageUrl: product.image ?? "",
                                  memCacheHeight: (0.25.sh).toInt(),
                                  memCacheWidth: (0.25.sh).toInt(),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(6.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CairoText(
                                      product.name ?? "",
                                      fontSize: 11.sp,
                                      maxLines: 1,
                                    ),
                                    SizedBox(height: 10.h),
                                    CairoText(
                                      product.description ?? "",
                                      maxLines: 2,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.6),
                                      fontSize: 11.sp,
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 9, left: 10, right: 10),
                                child: CairoText(
                                  textAlign: TextAlign.end,
                                  "${product.price}\$",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return CairoText("تعذر تحميل المنتجات");
              }
            },
          ),
        ],
      ),
    );
  }
}
