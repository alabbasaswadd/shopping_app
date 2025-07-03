import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/presentation/business_logic/cubit/shop/shop_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/shop/shop_state.dart';
import 'package:shopping_app/presentation/screens/shops/shops_products.dart';

class Shops extends StatefulWidget {
  Shops({super.key});
  static String id = "stores";

  @override
  State<Shops> createState() => _StoresState();
}

class _StoresState extends State<Shops> {
  late ShopCubit cubit;
  @override
  void initState() {
    cubit = ShopCubit();
    cubit.getShops();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: myAppBar("stores".tr, context),
      body: BlocBuilder<ShopCubit, ShopState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is ShopLoading) {
            return Center(
              child: SpinKitChasingDots(color: AppColor.kPrimaryColor),
            );
          } else if (state is ShopLoaded) {
            var shops = state.shops;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size.width > 600 ? 3 : 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: shops.length,
                itemBuilder: (context, index) => Card(
                  child: InkWell(
                    onTap: () {
                      Get.to(ShopProducts(shopId: state.shops[index].id ?? ""));
                    },
                    child: ListTile(
                      title: Text(shops[index].firstName ?? ""),
                      subtitle: Text(shops[index].id ?? ""),
                    ),
                  ),
                ),
              ),
            );
          } else if (state is ShopError) {
            print(state.error);
            return Text(state.error);
          } else {
            return Text("error");
          }
        },
      ),
    );
  }
}
