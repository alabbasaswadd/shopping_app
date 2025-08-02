import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_alert_dialog.dart';
import 'package:shopping_app/core/widgets/my_animation.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_button.dart';
import 'package:shopping_app/core/widgets/my_text.dart';
import 'package:shopping_app/data/model/delivery/delivery_data_model.dart';
import 'package:shopping_app/presentation/business_logic/cubit/delivery/delivery_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/delivery/delivery_state.dart';

class DeliveryCompanySelection extends StatefulWidget {
  const DeliveryCompanySelection({super.key});
  static String id = "delivery_company_selection_page";

  @override
  State<DeliveryCompanySelection> createState() =>
      _DeliveryCompanySelectionState();
}

class _DeliveryCompanySelectionState extends State<DeliveryCompanySelection> {
  late DeliveryCubit cubit;
  int? _expandedIndex;
  int? _selectedCompanyIndex;

  @override
  void initState() {
    cubit = DeliveryCubit();
    cubit.getDeliveryCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          myAppBar(title: "select_delivery_company".tr.tr, context: context),
      body: BlocConsumer<DeliveryCubit, DeliveryState>(
        bloc: cubit,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is DeliveryLoading) {
            return Center(
              child: SpinKitChasingDots(color: AppColor.kPrimaryColor),
            );
          } else if (state is DeliveryLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: state.deliveryCompanies.length,
                    itemBuilder: (context, index) {
                      final company = state.deliveryCompanies[index];
                      return _buildCompanyCard(company, index);
                    },
                  ),
                ),
                if (_selectedCompanyIndex != null)
                  _buildConfirmationButton(
                      state.deliveryCompanies[_selectedCompanyIndex!]),
              ],
            );
          } else {
            return Center(child: CairoText("delivery_company_error".tr));
          }
        },
      ),
    );
  }

  Widget _buildCompanyCard(DeliveryDataModel company, int index) {
    final isExpanded = _expandedIndex == index;
    final isSelected = _selectedCompanyIndex == index;

    return MyAnimation(
      scale: 0.98,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected ? AppColor.kPrimaryColor : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            setState(() {
              _expandedIndex = isExpanded ? null : index;
              if (!isExpanded) {
                _selectedCompanyIndex = index;
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Row(
                  children: [
                    // Company Logo
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.kPrimaryColor.withOpacity(0.1),
                        image: company.logoUrl != null
                            ? DecorationImage(
                                image: NetworkImage(company.logoUrl!),
                                fit: BoxFit.contain,
                              )
                            : null,
                      ),
                      child: company.logoUrl == null
                          ? Icon(Icons.local_shipping,
                              color: AppColor.kPrimaryColor)
                          : null,
                    ),
                    const SizedBox(width: 12),

                    // Company Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CairoText(
                            company.name ?? "delivery_company".tr,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.phone, size: 16, color: Colors.green),
                              const SizedBox(width: 4),
                              CairoText(
                                company.phoneNumber ?? "not_available".tr,
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Price and Arrow
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CairoText(
                          '${company.basePrice?.toStringAsFixed(2) ?? '--'}\$',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.kPrimaryColor,
                        ),
                        Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),

                // Expanded Details
                if (isExpanded) ...[
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 12),

                  // Contact Info
                  _buildDetailRow(
                    icon: Icons.email,
                    label: "email".tr,
                    value: company.email?.userName ?? "not_available".tr,
                  ),

                  _buildDetailRow(
                    icon: Icons.public,
                    label: "website".tr,
                    value: company.website ?? "not_available".tr,
                  ),

                  _buildDetailRow(
                    icon: Icons.location_on,
                    label: "address".tr,
                    value: company.address ?? "not_available".tr,
                  ),

                  // Coverage Areas
                  if (company.coverageAreas != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.map, size: 18, color: Colors.blue),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CairoText(
                                "coverage_areas".tr,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              CairoText(
                                company.coverageAreas!,
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],

                  // Pricing Details
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.attach_money, size: 18, color: Colors.orange),
                      const SizedBox(width: 8),
                      CairoText(
                        "pricing_details".tr,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CairoText(
                          '${"base_price".tr} ${company.basePrice?.toStringAsFixed(2) ?? '--'}\$',
                          fontSize: 14,
                        ),
                        CairoText(
                          '${"extra_km_price".tr} ${company.pricePerKm?.toStringAsFixed(2) ?? '--'}\$',
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),

                  // Select Button
                  const SizedBox(height: 16),
                  MyButton(
                    text: "select_this_company".tr,
                    onPressed: () {
                      setState(() {
                        _selectedCompanyIndex = index;
                        _expandedIndex = null;
                      });
                    },
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColor.kPrimaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CairoText(
                  label,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                CairoText(
                  value,
                  fontSize: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationButton(DeliveryDataModel selectedCompany) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: MyAnimation(
        child: Column(
          children: [
            MyButton(
              text: '${'confirm_selection'.tr}${selectedCompany.name}',
              onPressed: () {
                // تأكيد الاختيار وإرجاع البيانات
                Get.back(result: selectedCompany);
              },
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => MyAlertDialog(
                    title: "compare_prices".tr,
                    content: "compare_prompt".tr,
                    onOk: () {
                      Get.back();
                      setState(() {
                        _selectedCompanyIndex = null;
                        _expandedIndex = null;
                      });
                    },
                    onNo: () => Get.back(),
                  ),
                );
              },
              child: CairoText("compare_with_others".tr,
                  color: AppColor.kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
