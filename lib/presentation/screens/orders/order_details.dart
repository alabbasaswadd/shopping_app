import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/constants/const.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_button.dart';
import 'package:shopping_app/core/widgets/my_text.dart';
import 'package:shopping_app/core/widgets/my_animation.dart';
import 'package:shopping_app/data/model/order/order_data_model.dart';
import 'package:shopping_app/data/model/delivery/delivery_data_model.dart';
import 'package:shopping_app/presentation/business_logic/cubit/delivery/delivery_state.dart';
import 'package:shopping_app/presentation/business_logic/cubit/order/order_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/delivery/delivery_cubit.dart';

class OrderDetails extends StatefulWidget {
  final OrderDataModel order;

  const OrderDetails({super.key, required this.order});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late OrderCubit orderCubit;
  late DeliveryCubit deliveryCubit;
  DeliveryDataModel? selectedDeliveryCompany;
  bool showDeliveryDetails = false;
  bool noDeliverySelected = false;

  @override
  void initState() {
    orderCubit = OrderCubit();
    deliveryCubit = DeliveryCubit();
    deliveryCubit.getDeliveryCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'ar', symbol: 'ر.س');
    final isOnDelivery = widget.order.orderState == 'جاري التوصيل';

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => orderCubit),
        BlocProvider(create: (_) => deliveryCubit),
      ],
      child: Scaffold(
        appBar: myAppBar(
          title: 'تفاصيل الطلب #${widget.order.id}',
          context: context,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Status Card
              _buildInfoCard(
                "الحالة الحالية:",
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

              // Total Section
              _buildTotalSection(currencyFormat),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomActionBar(isOnDelivery),
      ),
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
          CairoText('تفاصيل المنتجات',
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
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child:
                              CairoText('المنتج', fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child:
                              CairoText('الكمية', fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child:
                              CairoText('السعر', fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: CairoText('الإجمالي',
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
      children: const [
        Icon(Icons.local_shipping, color: AppColor.kPrimaryColor),
        SizedBox(width: 8),
        CairoText(
          'خيارات التوصيل',
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }

  Widget _buildDeliverySelectionSection() {
    return BlocBuilder<DeliveryCubit, DeliveryState>(
      builder: (context, state) {
        if (state is DeliveryLoading) {
          return const Center(child: CircularProgressIndicator());
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
                    hint: const CairoText("اختر شركة التوصيل"),
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Cairo",
                      color: Colors.black,
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: CairoText("بدون شركة توصيل"),
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
                                  company.name ?? 'شركة التوصيل',
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
                    children: const [
                      Icon(Icons.close, size: 18, color: Colors.grey),
                      SizedBox(width: 4),
                      CairoText(
                        'المتابعة بدون توصيل',
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
            ],
          );
        } else {
          return const CairoText("فشل تحميل شركات التوصيل");
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
                          company.name ?? 'شركة التوصيل',
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
                      '${company.basePrice?.toStringAsFixed(2) ?? '--'} ر.س',
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
                    title: 'البريد الإلكتروني',
                    value: company.email?.userName ?? 'غير متوفر',
                  ),
                  _buildDetailItem(
                    icon: Icons.public,
                    title: 'الموقع الإلكتروني',
                    value: company.website ?? 'غير متوفر',
                  ),
                  _buildDetailItem(
                    icon: Icons.location_on,
                    title: 'العنوان',
                    value: company.address ?? 'غير متوفر',
                  ),
                  _buildDetailItem(
                    icon: Icons.map,
                    title: 'المناطق المشمولة',
                    value: company.coverageAreas ?? 'جميع المناطق',
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
                      'تفاصيل الأسعار',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    _buildPriceDetailRow(
                      'السعر الأساسي',
                      '${company.basePrice?.toStringAsFixed(2) ?? '--'} ر.س',
                    ),
                    _buildPriceDetailRow(
                      'سعر الكيلومتر الإضافي',
                      '${company.pricePerKm?.toStringAsFixed(2) ?? '--'} ر.س',
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
                      'سيتم الاستلام من المتجر',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    CairoText(
                      'يمكنك اختيار شركة توصيل لاحقاً من خلال صفحة الطلب',
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
            _buildTotalRow('إجمالي الطلب:', currencyFormat.format(orderTotal)),
            _buildTotalRow(
              'تكلفة التوصيل:',
              selectedDeliveryCompany != null
                  ? currencyFormat.format(deliveryCost)
                  : '—',
            ),
            const Divider(height: 20),
            _buildTotalRow(
              'الإجمالي الكلي:',
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
                text: 'جاري التوصيل',
                color: Colors.grey,
                onPressed: () {},
              )
            else if (selectedDeliveryCompany != null)
              MyButton(
                text: 'بدء التوصيل مع ${selectedDeliveryCompany!.name}',
                onPressed: () => _startDelivery(context),
              )
            else if (noDeliverySelected)
              MyButton(
                text: 'تأكيد الاستلام من المتجر',
                onPressed: () => _confirmStorePickup(context),
              )
            else
              MyButton(
                text: 'اختر طريقة التوصيل',
                color: Colors.grey,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('الرجاء اختيار طريقة التوصيل أولاً'),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  void _startDelivery(BuildContext context) {
    setState(() {
      widget.order.orderState = OrderStateEnum.inTransit;
      widget.order.deliveryCompanyId = selectedDeliveryCompany!.id;
    });

    orderCubit.updateOrder(widget.order.id!, widget.order);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم بدء التوصيل مع ${selectedDeliveryCompany!.name}'),
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
      const SnackBar(
        content: Text('تم تأكيد الاستلام من المتجر'),
      ),
    );
  }
}
