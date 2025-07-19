import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/core/constants/cached/cached_image.dart';
import 'package:shopping_app/core/widgets/my_animation.dart';
import 'package:shopping_app/core/widgets/my_card.dart';
import 'package:shopping_app/core/widgets/my_text.dart';
import 'package:shopping_app/data/model/products/product_data_model.dart';
import 'package:shopping_app/presentation/business_logic/cubit/products/products_cubit.dart';
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
    cubit = ProductsCubit();
    cubit.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                    CairoText(widget.product.name ?? ""),
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
                  color: Colors.black54,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ListView أفقية – نحتاج ارتفاع هنا لأنه scroll أفقي
          Container(
            height: 350.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, i) => MyAnimation(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(ProductDetails.id,
                            arguments: widget.product);
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
                                imageUrl: widget.product.image ?? "",
                                memCacheHeight: (0.25.sh).toInt(),
                                memCacheWidth: (0.25.sh).toInt(),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(6.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CairoText("fd", fontSize: 11.sp, maxLines: 1),
                                  SizedBox(height: 10.h),
                                  CairoText(
                                    "as",
                                    maxLines: 2,
                                    color: Colors.black54,
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
                                "asd",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      right: 2,
                      top: 2,
                      child: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.favorite_border_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          BlocConsumer<ProductsCubit, ProductsState>(
            bloc: cubit,
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ProductsLoaded) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.5.h,
                  ),
                  itemBuilder: (context, i) {
                    final product = state.products[i];
                    return MyAnimation(
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(ProductDetails.id,
                                  arguments: product);
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          color: Colors.black54,
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
                          const Positioned(
                            right: 2,
                            top: 2,
                            child: IconButton(
                              onPressed: null,
                              icon: Icon(Icons.favorite_border_outlined),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return CairoText("Error");
              }
            },
          ),
        ],
      ),
    );
  }
}
