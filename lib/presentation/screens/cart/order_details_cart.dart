import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/constants/const.dart';
import 'package:shopping_app/core/constants/functions.dart';
import 'package:shopping_app/core/widgets/my_alert_dialog.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_button.dart';
import 'package:shopping_app/core/widgets/my_snackbar.dart';
import 'package:shopping_app/core/widgets/my_text.dart';
import 'package:shopping_app/core/widgets/my_animation.dart';
import 'package:shopping_app/core/widgets/my_text_form_field.dart';
import 'package:shopping_app/data/model/order/order_data_model.dart';
import 'package:shopping_app/data/model/delivery/delivery_data_model.dart';
import 'package:shopping_app/data/model/order/order_request_data_model.dart';
import 'package:shopping_app/data/model/order/order_request_item_model.dart';
import 'package:shopping_app/presentation/business_logic/cubit/delivery/delivery_state.dart';
import 'package:shopping_app/presentation/business_logic/cubit/order/order_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/delivery/delivery_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/order/order_state.dart';

class OrderDetailsCart extends StatefulWidget {
  final OrderDataModel order;

  const OrderDetailsCart({super.key, required this.order});

  @override
  State<OrderDetailsCart> createState() => _OrderDetailsCartState();
}

class _OrderDetailsCartState extends State<OrderDetailsCart> {
  late OrderCubit orderCubit;
  late DeliveryCubit deliveryCubit;
  DeliveryDataModel? selectedDeliveryCompany;
  bool showDeliveryDetails = false;
  bool noDeliverySelected = false;
  String deliveryCompanyId = "";
  TextEditingController _noteController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    orderCubit = OrderCubit();
    deliveryCubit = DeliveryCubit();
    deliveryCubit.getDeliveryCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'ar', symbol: "\$");
    final isOnDelivery = widget.order.orderState == 'جاري التوصيل';

    return Scaffold(
      appBar: myAppBar(
        title: '${"order_details_title".tr}${widget.order.id}',
        context: context,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Status Card
            _buildInfoCard(
              "current_status".tr,
              widget.order.orderState?.name ?? "",
              icon: Icons.info_outline,
              iconColor: AppColor.kPrimaryColor,
            ),
            const SizedBox(height: 16),

            // Products Table
            _buildProductTable(currencyFormat),
            const SizedBox(height: 24),

            // Delivery Company Section
            _buildDeliveryHeader(),
            const SizedBox(height: 8),

            // Delivery Company Selection
            _buildDeliverySelectionSection(),

            // Delivery Company Details
            if (showDeliveryDetails && selectedDeliveryCompany != null)
              _buildDeliveryCompanyCard(selectedDeliveryCompany!),

            if (noDeliverySelected) _buildNoDeliverySelectedCard(),

            const SizedBox(height: 24),
            _buildInertForm(),
            // Total Section
            _buildTotalSection(currencyFormat),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActionBar(isOnDelivery),
    );
  }

  Widget _buildInfoCard(String label, String value,
      {IconData? icon, Color? iconColor}) {
    return MyAnimation(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: iconColor),
              const SizedBox(width: 8),
            ],
            Expanded(child: CairoText(label, color: Colors.grey[600])),
            CairoText(value, fontWeight: FontWeight.bold),
          ],
        ),
      ),
    );
  }

  Widget _buildProductTable(NumberFormat currencyFormat) {
    final items = widget.order.orderItems ?? [];

    return MyAnimation(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CairoText("products_details".tr,
              fontSize: 16, fontWeight: FontWeight.bold),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(6),
                1: FlexColumnWidth(4),
                2: FlexColumnWidth(3),
                3: FlexColumnWidth(4),
              },
              border: TableBorder.symmetric(
                inside: BorderSide(color: Colors.grey.shade300),
              ),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: AppColor.kPrimaryColor.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: CairoText("product".tr,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: CairoText('quantity'.tr,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: CairoText('price'.tr,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: CairoText('total'.tr,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                ...items.map((item) {
                  final name = item.productName ?? '—';
                  final qty = item.quantity ?? 0;
                  final price = item.price ?? 0.0;
                  final total = qty * price;

                  return TableRow(
                    decoration: BoxDecoration(
                      color: items.indexOf(item) % 2 == 0
                          ? Colors.white
                          : Colors.grey.shade50,
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: CairoText(name, fontSize: 13, maxLines: 1)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: CairoText('$qty', fontSize: 13)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: CairoText(price.toStringAsFixed(2),
                                fontSize: 13)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: CairoText(total.toStringAsFixed(2),
                                fontSize: 13)),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryHeader() {
    return Row(
      children: [
        Icon(Icons.local_shipping, color: AppColor.kPrimaryColor),
        SizedBox(width: 8),
        CairoText(
          "delivery_options".tr,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }

  Widget _buildDeliverySelectionSection() {
    return BlocBuilder<DeliveryCubit, DeliveryState>(
      bloc: deliveryCubit,
      builder: (context, state) {
        if (state is DeliveryLoading) {
          return SpinKitChasingDots(color: AppColor.kPrimaryColor);
        } else if (state is DeliveryLoaded) {
          return Column(
            children: [
              // Delivery Company Dropdown
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<DeliveryDataModel>(
                    value: selectedDeliveryCompany,
                    hint: CairoText("select_delivery_company".tr),
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Cairo",
                      color: Colors.black,
                    ),
                    items: [
                      DropdownMenuItem(
                        value: null,
                        child: CairoText("no_delivery_company".tr),
                      ),
                      ...state.deliveryCompanies.map((company) {
                        return DropdownMenuItem<DeliveryDataModel>(
                          value: company,
                          child: Row(
                            children: [
                              if (company.logoUrl != null)
                                Container(
                                  width: 30,
                                  height: 30,
                                  margin: const EdgeInsets.only(left: 8),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(company.logoUrl!),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              Expanded(
                                child: CairoText(
                                  company.name ?? "delivery_company".tr,
                                  fontSize: 14,
                                ),
                              ),
                              CairoText(
                                '${company.basePrice?.toStringAsFixed(2) ?? '--'} ر.س',
                                fontSize: 14,
                                color: AppColor.kPrimaryColor,
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedDeliveryCompany = value;
                        deliveryCompanyId = selectedDeliveryCompany?.id ?? '';
                        noDeliverySelected = value == null;
                        showDeliveryDetails = value != null;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Or continue without delivery
              if (!noDeliverySelected && !showDeliveryDetails)
                TextButton(
                  onPressed: () {
                    setState(() {
                      noDeliverySelected = true;
                      selectedDeliveryCompany = null;
                      showDeliveryDetails = false;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.close, size: 18, color: Colors.grey),
                      SizedBox(width: 4),
                      CairoText(
                        "continue_without_delivery".tr,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
            ],
          );
        } else if (state is DeliveryEmpty) {
          return CairoText("no_delivery_companies".tr);
        } else {
          return CairoText("failed_loading_delivery_companies".tr);
        }
      },
    );
  }

  Widget _buildDeliveryCompanyCard(DeliveryDataModel company) {
    return MyAnimation(
      child: Card(
        margin: const EdgeInsets.only(top: 12),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColor.kPrimaryColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company Header
              Row(
                children: [
                  if (company.logoUrl != null)
                    Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(company.logoUrl!),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CairoText(
                          company.name ?? "delivery_company".tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (company.phoneNumber != null)
                          CairoText(
                            company.phoneNumber!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.kPrimaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: CairoText(
                      '${company.basePrice?.toStringAsFixed(2) ?? '--'} \$',
                      style: TextStyle(
                        color: AppColor.kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Company Details Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 3.5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  _buildDetailItem(
                    icon: Icons.email,
                    title: "email".tr,
                    value: company.email?.userName ?? "email_unavailable".tr,
                  ),
                  _buildDetailItem(
                    icon: Icons.public,
                    title: "website".tr,
                    value: company.website ?? "website_unavailable".tr,
                  ),
                  _buildDetailItem(
                    icon: Icons.location_on,
                    title: "address".tr,
                    value: company.address ?? "address_unavailable".tr,
                  ),
                  _buildDetailItem(
                    icon: Icons.map,
                    title: "coverage_areas".tr,
                    value: company.coverageAreas ?? "all_areas".tr,
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Pricing Details
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CairoText(
                      "price_details".tr,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    _buildPriceDetailRow(
                      "base_price".tr,
                      '${company.basePrice?.toStringAsFixed(2) ?? '--'} \$',
                    ),
                    _buildPriceDetailRow(
                      "price_per_km".tr,
                      '${company.pricePerKm?.toStringAsFixed(2) ?? '--'} \$',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColor.kPrimaryColor),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CairoText(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              CairoText(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CairoText(label, fontSize: 14),
          CairoText(
            value,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColor.kPrimaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildNoDeliverySelectedCard() {
    return MyAnimation(
      child: Card(
        margin: const EdgeInsets.only(top: 12),
        color: Colors.blue.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.blue.shade100),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade600),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CairoText(
                      "store_pickup".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    CairoText(
                      "choose_delivery_later".tr,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInertForm() {
    return Column(
      children: [
        MyTextFormField(
          controller: _noteController,
          label: "note_delivery".tr,
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () async {
            final now = DateTime.now();
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: now,
              firstDate: now,
              lastDate: now.add(Duration(days: 30)),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      // ← يجعل النص أبيض والخلفية داكنة
                      primary: AppColor.kPrimaryColor, // لون التحديد
                      onPrimary: Colors.white, // لون نص الزر المحدد
                      onSurface: Colors.black, // ← لون النص داخل التقويم
                    ),
                  ),
                  child: child!,
                );
              },
            );

            if (pickedDate != null) {
              setState(() {
                _selectedDate = pickedDate;
                _dateController.text =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
              });
            }
          },
          child: AbsorbPointer(
            child: MyTextFormField(
              controller: _dateController,
              label: "delivery_start_date".tr,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTotalSection(NumberFormat currencyFormat) {
    double deliveryCost = selectedDeliveryCompany?.basePrice ?? 0;
    double orderTotal = widget.order.totalAmount ?? 0;
    double grandTotal = orderTotal + deliveryCost;

    return MyAnimation(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            _buildTotalRow("order_total".tr, currencyFormat.format(orderTotal)),
            _buildTotalRow(
              "delivery_cost".tr,
              selectedDeliveryCompany != null
                  ? currencyFormat.format(deliveryCost)
                  : '—',
            ),
            const Divider(height: 20),
            _buildTotalRow(
              "grand_total".tr,
              currencyFormat.format(grandTotal),
              isBold: true,
              color: AppColor.kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow(String label, String value,
      {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CairoText(label,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          CairoText(
            value,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: color,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar(bool isOnDelivery) {
    return MyAnimation(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isOnDelivery)
              MyButton(
                text: "delivery_in_progress".tr,
                color: Colors.grey,
                onPressed: () {},
              )
            else if (selectedDeliveryCompany != null)
              BlocConsumer<OrderCubit, OrderState>(
                bloc: orderCubit,
                listener: (context, state) {
                  if (state is OrderAdded) {
                    MySnackbar.showSuccess(context, "send_order".tr);
                  } else if (state is OrderError) {
                    MySnackbar.showError(
                        context, "${"order_send_failed".tr} ${state.error}");
                  }
                },
                builder: (context, state) {
                  return MyAnimation(
                    scale: 0.90,
                    child: MyButton(
                        isLoading: false,
                        text: "send_order_title".tr,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => MyAlertDialog(
                                  onOk: () async {
                                    final order = OrderRequestDataModel(
                                      addressId: UserSession.addressId ?? "",
                                      shippedDate:
                                          _selectedDate ?? DateTime.now(),
                                      noteDelivery: _noteController.text,
                                      deliveryCompanyId: deliveryCompanyId,
                                      customerId: UserSession.id ?? "",
                                      shopId: widget.order.shopId ?? '',
                                      orderDate: DateTime.now(),
                                      totalAmount:
                                          widget.order.totalAmount ?? 0,
                                      orderState: 0,
                                      orderItems: widget.order.orderItems!
                                          .map((item) => OrderRequestItemModel(
                                                productId: item.productId ?? "",
                                                quantity: item.quantity ?? 0,
                                                price: item.price ?? 0,
                                              ))
                                          .toList(),
                                    );
                                    await orderCubit.addOrder(order);
                                    Get.back();
                                  },
                                  onNo: () {
                                    Get.back();
                                  },
                                  title: "send_order".tr,
                                  content: "send_order_content".tr));
                        }),
                  );
                },
              )
            else if (noDeliverySelected)
              MyButton(
                text: "confirm_store_pickup".tr,
                onPressed: () => _confirmStorePickup(context),
              )
            else
              MyButton(
                text: "choose_delivery_method".tr,
                color: Colors.grey,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("please_choose_delivery_method".tr),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  void _confirmStorePickup(BuildContext context) {
    setState(() {
      widget.order.orderState = OrderStateEnum.inTransit;
      widget.order.deliveryCompanyId = null;
    });

    orderCubit.updateOrder(widget.order.id!, widget.order);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("confirm_store_pickup_success".tr),
      ),
    );
  }
}
