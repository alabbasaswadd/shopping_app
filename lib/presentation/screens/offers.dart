import 'dart:async';
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
import 'package:shopping_app/data/model/offer/offer_response_model.dart';
import 'package:shopping_app/presentation/business_logic/cubit/offer/offer_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/offer/offer_state.dart';
import 'package:shopping_app/presentation/screens/products/product_details.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});
  static String id = "offers";

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  late OfferCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = OfferCubit();
    cubit.getOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "offers".tr, context: context),
      body: BlocConsumer<OfferCubit, OfferState>(
        bloc: cubit,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is OfferLoading) {
            return Center(
              child: SpinKitChasingDots(color: AppColor.kPrimaryColor),
            );
          } else if (state is OfferEmpty) {
            return Center(
              child: CairoText("no_offers"),
            );
          } else if (state is OfferLoaded) {
            return _buildOfferList(state.offers);
          } else {
            return Center(
              child: CairoText("error".tr),
            );
          }
        },
      ),
    );
  }

  Widget _buildOfferList(OfferResponseModel offers) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: offers.data?.length ?? 0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 0.65.sh / 1000,
        ),
        itemBuilder: (context, index) {
          final offer = offers.data![index];
          final discount = offer.discountPercentage ?? 0;
          final newPrice = offer.newPrice ?? 0;
          final oldPrice = newPrice / (1 - discount / 100);

          return MyAnimation(
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(ProductDetails(), arguments: offer.product);
                  },
                  child: MyCard(
                    padding: EdgeInsets.zero,
                    elevation: 5,
                    borderRadius: BorderRadius.circular(16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16.r)),
                          child: CachedImageWidget(
                            heightRatio: 178,
                            widthRatio: 200,
                            imageUrl: offer.imageUrl ?? "",
                            memCacheHeight: (0.25.sh).toInt(),
                            memCacheWidth: (0.25.sh).toInt(),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 6.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CairoText(
                                  offer.name ?? "",
                                  fontSize: 12.sp,
                                  maxLines: 1,
                                ),
                                SizedBox(height: 8.h),
                                CairoText(
                                  offer.product?.description ?? "",
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CairoText(
                                      "${newPrice.toStringAsFixed(2)}${offer.product?.currency ?? ""}",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: AppColor.kPrimaryColor,
                                      ),
                                    ),
                                    CairoText(
                                      "${oldPrice.toStringAsFixed(2)} ${offer.product?.currency ?? ""}",
                                      style: TextStyle(
                                          color: Colors.red,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor: Colors.red),
                                      fontSize: 15,
                                    ),
                                    SizedBox(width: 6.w),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (offer.endDate!.isAfter(DateTime.now()))
                  Positioned(
                      top: 6,
                      left: 6,
                      right: 60,
                      child: OfferCountdown(endDate: offer.endDate!)),
                if (discount > 0)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: CairoText(
                          "-${discount.toStringAsFixed(0)}%",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OfferCountdown extends StatefulWidget {
  final DateTime endDate;

  const OfferCountdown({super.key, required this.endDate});

  @override
  State<OfferCountdown> createState() => _OfferCountdownState();
}

class _OfferCountdownState extends State<OfferCountdown> {
  late Timer _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _calculateRemaining();
    _startTimer();
  }

  void _calculateRemaining() {
    final now = DateTime.now();
    setState(() {
      _remaining = widget.endDate.difference(now);
      if (_remaining.isNegative) {
        _remaining = Duration.zero;
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateRemaining();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    return '${days}d ${hours.toString().padLeft(2, '0')}h '
        '${minutes.toString().padLeft(2, '0')}m '
        '${seconds.toString().padLeft(2, '0')}s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: CairoText(
          _formatDuration(_remaining),
          color: Colors.white,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
