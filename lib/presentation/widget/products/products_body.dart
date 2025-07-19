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
import 'package:shopping_app/data/model/products/product_data_model.dart';
import 'package:shopping_app/presentation/business_logic/cubit/products/products_cubit.dart';
import 'package:shopping_app/presentation/screens/products/product_details.dart';

class ProductsBody extends StatefulWidget {
  const ProductsBody({super.key});

  @override
  State<ProductsBody> createState() => _ProductsBodyState();
}

class _ProductsBodyState extends State<ProductsBody> {
  late ProductsCubit cubit;
  String selectedCategory = "";
  String? selectedStore;
  RangeValues priceRange = const RangeValues(0, 1000);

  @override
  void initState() {
    super.initState();
    cubit = ProductsCubit();
    cubit.getProducts();
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
          return Column(
            children: [
              _buildFilterSection(),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: state.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.5.h,
                  ),
                  itemBuilder: (context, i) {
                    final product = state.products[i];
                    return _buildProductCard(product);
                  },
                ),
              ),
            ],
          );
        } else if (state is ProductsError) {
          return Center(
            child: Text(
              "Error: ${state.error}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(child: Text("Unexpected state"));
        }
      },
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildCategoryFilter(),
              const SizedBox(width: 8),
              _buildStoreFilter(),
              const SizedBox(width: 8),
              _buildPriceFilter(),
            ],
          ),
          if (selectedCategory.isNotEmpty || selectedStore != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  if (selectedCategory.isNotEmpty)
                    _buildActiveFilterChip(
                      label: selectedCategory,
                      onDeleted: () => _clearFilter('category'),
                    ),
                  if (selectedStore != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: _buildActiveFilterChip(
                        label: selectedStore!,
                        onDeleted: () => _clearFilter('store'),
                      ),
                    ),
                  const Spacer(),
                  TextButton(
                    onPressed: _clearAllFilters,
                    child: const Text(
                      'مسح الكل',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCategory.isNotEmpty ? selectedCategory : null,
              hint: const CairoText(
                "الفئة",
                fontSize: 11,
              ),
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: "Cairo-Bold",
              ),
              items: [
                const DropdownMenuItem(
                  value: "",
                  child: CairoText(
                    "الكل",
                    fontSize: 11,
                  ),
                ),
                ...["إلكترونيات", "ملابس", "عطور", "مستلزمات منزلية"]
                    .map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: CairoText(
                      category,
                      fontSize: 11,
                    ),
                  );
                }),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedCategory = value);
                  cubit.getProducts(category: value.isEmpty ? null : value);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStoreFilter() {
    return GestureDetector(
      onTap: _showStoreFilterBottomSheet,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.store, size: 20, color: AppColor.kPrimaryColor),
            const SizedBox(width: 4),
            Text(
              selectedStore ?? "المتجر",
              style: TextStyle(
                fontSize: 13.sp,
                color: selectedStore != null ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceFilter() {
    return GestureDetector(
      onTap: _showPriceFilterDialog,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: const Icon(Icons.price_change,
            size: 20, color: AppColor.kPrimaryColor),
      ),
    );
  }

  Widget _buildActiveFilterChip({
    required String label,
    required VoidCallback onDeleted,
  }) {
    return Chip(
      label: Text(label),
      backgroundColor: AppColor.kPrimaryColor.withOpacity(0.1),
      deleteIcon: const Icon(Icons.close, size: 16),
      onDeleted: onDeleted,
      labelStyle: TextStyle(
        color: AppColor.kPrimaryColor,
        fontSize: 12.sp,
      ),
    );
  }

  Widget _buildProductCard(ProductDataModel product) {
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
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16.r)),
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
                  const Spacer(),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 9, left: 10, right: 10),
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
              icon: const Icon(Icons.favorite_border_outlined),
            ),
          )
        ],
      ),
    );
  }

  void _showStoreFilterBottomSheet() {
    final stores = ["متجر إدلب", "متجر حلب", "متجر دمشق", "متجر اللاذقية"];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "اختر المتجر",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...stores.map((store) {
                return ListTile(
                  title: Text(store),
                  trailing: selectedStore == store
                      ? const Icon(Icons.check, color: AppColor.kPrimaryColor)
                      : null,
                  onTap: () {
                    setState(() => selectedStore = store);
                    cubit.getProducts(shopId: store);
                    Navigator.pop(context);
                  },
                );
              }),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  setState(() => selectedStore = null);
                  cubit.getProducts(shopId: null);
                  Navigator.pop(context);
                },
                child: const Text(
                  "إلغاء التحديد",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showPriceFilterDialog() async {
    final result = await showDialog<RangeValues>(
      context: context,
      builder: (_) => _PriceRangeDialog(initialRange: priceRange),
    );

    if (result != null) {
      setState(() => priceRange = result);
      cubit.getProducts(
        minPrice: result.start,
        maxPrice: result.end,
      );
    }
  }

  void _clearFilter(String type) {
    setState(() {
      if (type == 'category') {
        selectedCategory = "";
      } else if (type == 'store') {
        selectedStore = null;
      }
    });
    cubit.getProducts();
  }

  void _clearAllFilters() {
    setState(() {
      selectedCategory = "";
      selectedStore = null;

      priceRange = const RangeValues(0, 1000);
    });
    cubit.getProducts();
  }
}

class _PriceRangeDialog extends StatefulWidget {
  final RangeValues initialRange;

  const _PriceRangeDialog({required this.initialRange});

  @override
  State<_PriceRangeDialog> createState() => _PriceRangeDialogState();
}

class _PriceRangeDialogState extends State<_PriceRangeDialog> {
  late RangeValues _currentRange;

  @override
  void initState() {
    super.initState();
    _currentRange = widget.initialRange;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("فلترة حسب السعر"),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RangeSlider(
              values: _currentRange,
              min: 0,
              max: 1000,
              divisions: 10,
              labels: RangeLabels(
                _currentRange.start.round().toString(),
                _currentRange.end.round().toString(),
              ),
              onChanged: (values) {
                setState(() => _currentRange = values);
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${_currentRange.start.round()} \$"),
                Text("${_currentRange.end.round()} \$"),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("إلغاء"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _currentRange),
          child: const Text("تطبيق"),
        ),
      ],
    );
  }
}
