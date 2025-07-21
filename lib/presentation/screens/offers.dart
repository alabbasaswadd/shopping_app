import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';

import 'package:shopping_app/core/constants/images.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_text.dart';
import 'package:shopping_app/data/model/offer/offer_data_model.dart';
import 'package:shopping_app/data/model/offer/offer_response_model.dart';
import 'package:shopping_app/presentation/business_logic/offer/offer_cubit.dart';
import 'package:shopping_app/presentation/business_logic/offer/offer_state.dart';

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
              child: CairoText("Error"),
            );
          }
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.klogo,
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOfferList(OfferResponseModel offers) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: offers.data?.length ?? 0,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final offer = offers.data?[index];
        return ListTile(
          leading: Image.network(
            offer?.imageUrl ?? "",
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          title: Text(offer?.name ?? ""),
          subtitle:
              Text('${offer?.newPrice ?? 0} ${offer?.product?.currency ?? 0}'),
          trailing: Text(
            "-${offer?.discountPercentage ?? 0}%",
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
