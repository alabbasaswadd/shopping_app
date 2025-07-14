import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/cached/cached_image.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_animation.dart';
import 'package:shopping_app/core/widgets/my_card.dart';
import 'package:shopping_app/core/widgets/my_snackbar.dart';
import 'package:shopping_app/core/widgets/my_text.dart';
import 'package:shopping_app/presentation/business_logic/cubit/products/products_cubit.dart';
import 'package:shopping_app/presentation/screens/products/product_details.dart';

class ProductsBody extends StatefulWidget {
  const ProductsBody({super.key});

  @override
  State<ProductsBody> createState() => _ProductsBodyState();
}

class _ProductsBodyState extends State<ProductsBody> {
  late ProductsCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = ProductsCubit();
    cubit.getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is ProductsFeildAdd) {
          MySnackbar.showError(context, "Error: ${state.error}");
        } else if (state is ProductsAdded) {
          MySnackbar.showSuccess(context, "تمت الإضافة");
        }
      },
      builder: (context, state) {
        if (state is ProductsLoading) {
          return Center(
            child: SpinKitChasingDots(color: AppColor.kPrimaryColor),
          );
        } else if (state is ProductsLoaded) {
          return GridView.builder(
            itemCount: state.products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.5.h
                // 1.sw / 0.78.sh, // عرض 45% من الشاشة ÷ ارتفاع 33% من الشاشة
                ),
            itemBuilder: (context, i) {
              final product = state.products[i];
              return MyAnimation(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(ProductDetails.id, arguments: product);
                      },
                      child: MyCard(
                        margin: EdgeInsets.all(7),
                        padding: EdgeInsets.zero,
                        elevation: 6,
                        borderRadius: BorderRadius.circular(16.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.r)),
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
                                    color: Colors.black54,
                                    fontSize: 11.sp,
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
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
                    Positioned(
                      right: 2,
                      top: 2,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border_outlined,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        } else if (state is ProductsError) {
          return Center(
            child: Text(
              "Error: ${state.error}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return Center(child: Text("Unexpected state"));
        }
      },
    );
  }
}
