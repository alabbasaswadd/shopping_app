import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_card.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});
  static String id = "notifications";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "notifications".tr, context: context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "today".tr,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
              ),
            ),
            _buildNotificationCard(
              context,
              icon: Icons.discount,
              title: "خصم خاص اليوم فقط".tr,
              message: "احصل على خصم 20% على جميع المنتجات حتى منتصف الليل".tr,
              time: "10:30 ص",
              isUnread: true,
              iconColor: Colors.redAccent,
            ),
            _buildNotificationCard(
              context,
              icon: Icons.local_shipping,
              title: "تم شحن طلبك".tr,
              message: "طلبك رقم #12345 في طريق إليك الآن".tr,
              time: "09:15 ص",
              isUnread: true,
              iconColor: Colors.blueAccent,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "الأمس".tr,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
              ),
            ),
            _buildNotificationCard(
              context,
              icon: Icons.account_circle,
              title: "مرحباً بعودتك!".tr,
              message: "لقد فقت منذ 3 أيام، لدينا عروض جديدة تنتظرك".tr,
              time: "05:20 م",
              isUnread: false,
              iconColor: Colors.purpleAccent,
            ),
            _buildNotificationCard(
              context,
              icon: Icons.payment,
              title: "تمت عملية الدفع بنجاح".tr,
              message: "تم خصم مبلغ 150 ريال لشراء المنتج #67890".tr,
              time: "11:45 ص",
              isUnread: false,
              iconColor: Colors.green,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "هذا الأسبوع".tr,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
              ),
            ),
            _buildNotificationCard(
              context,
              icon: Icons.star_rate,
              title: "قيم تجربتك".tr,
              message: "كيف كانت تجربة شرائك لآخر منتج؟".tr,
              time: "الاثنين",
              isUnread: false,
              iconColor: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String message,
    required String time,
    required bool isUnread,
    required Color iconColor,
  }) {
    return MyCard(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          border: isUnread
              ? Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  width: 1,
                )
              : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: isUnread
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                        ),
                        Text(
                          time,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[700],
                          ),
                    ),
                  ],
                ),
              ),
              if (isUnread)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
