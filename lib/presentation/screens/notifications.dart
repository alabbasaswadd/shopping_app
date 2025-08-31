import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_animation.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_card.dart';
import 'package:shopping_app/core/widgets/my_text.dart';
import 'package:shopping_app/data/model/notifications/notifications_data_model.dart';
import 'package:shopping_app/presentation/business_logic/cubit/notifications/notifications_cubit.dart';
import 'package:shopping_app/presentation/business_logic/cubit/notifications/notifications_state.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});
  static String id = "notifications";

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late NotificationsCubit cubit;
  @override
  void initState() {
    cubit = NotificationsCubit();
    cubit.getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "notifications".tr, context: context),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is NotificationsLoading) {
            return Center(
              child: SpinKitChasingDots(color: AppColor.kPrimaryColor),
            );
          } else if (state is NotificationsLoaded) {
            return ListView.builder(
                itemCount: state.notifications.length,
                itemBuilder: (context, i) => _buildNotificationCard(
                      context,
                      notification: state.notifications[i],
                      isUnread: true,
                      icon: Icons.notifications,
                      iconColor: Colors.orange,
                    ));
          } else if (state is NotificationsEmpty) {
            return Center(child: CairoText("no_notifications".tr));
          } else {
            return Center(child: CairoText("Error".tr));
          }
        },
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context, {
    required NotificationsModel notification,
    required bool isUnread,
    required IconData icon,
    required Color iconColor,
  }) {
    return MyAnimation(
      child: MyCard(
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
                      // العنوان
                      Text(
                        "العنوان: ${notification.title}",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: isUnread
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                      ),
                      const SizedBox(height: 4),

                      // الرسالة
                      Text(
                        "الشرح: ${notification.message}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[800],
                            ),
                      ),
                      const SizedBox(height: 6),

                      // التاريخ
                      Text(
                        "التاريخ: ${_formatDate(notification.created)}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                      ),

                      const SizedBox(height: 6),

                      // النوع
                      Text(
                        "النوع: ${notification.type}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[700],
                            ),
                      ),
                    ],
                  ),
                ),

                // نقطة حمراء إذا غير مقروء
                if (isUnread)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} دقيقة';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ساعة';
    } else {
      return '${difference.inDays} يوم';
    }
  }
}
