import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/presentation/screens/cart.dart';
import 'package:shopping_app/presentation/screens/filter.dart';
import 'package:shopping_app/presentation/screens/notifications.dart';

class ProductsAppbarActions extends StatelessWidget {
  const ProductsAppbarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Filter Button with Badge
        _buildActionButton(
          icon: Icons.filter_alt_outlined,
          onPressed: () => _showFilterBottomSheet(context),
          showBadge: true,
          badgeCount: 3, // يمكن تعديل الرقم حسب الحاجة
        ),

        // Notifications Button with Badge
        _buildActionButton(
          icon: Icons.notifications_outlined,
          onPressed: () => Navigator.pushNamed(context, Notifications.id),
          showBadge: true,
          badgeCount: 7, // يمكن تعديل الرقم حسب الحاجة
        ),

        // Shopping Cart Button with Badge
        _buildActionButton(
          icon: Icons.shopping_cart_outlined,
          onPressed: () => Navigator.pushNamed(context, CardPage.id),
          showBadge: true,
          badgeCount: 2, // يمكن تعديل الرقم حسب الحاجة
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
    bool showBadge = false,
    int badgeCount = 0,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
          splashRadius: 20,
          tooltip: _getTooltip(icon),
        ),
        if (showBadge && badgeCount > 0)
          Positioned(
            top: 5,
            right: 5,
            child: Container(
              padding: EdgeInsets.all(2),
              constraints: BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              decoration: BoxDecoration(
                color: AppColor.kRedColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                badgeCount.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  String _getTooltip(IconData icon) {
    switch (icon) {
      case Icons.filter_alt_outlined:
        return 'Filter Products';
      case Icons.notifications_outlined:
        return 'Notifications';
      case Icons.shopping_cart_outlined:
        return 'Shopping Cart';
      default:
        return '';
    }
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const Filter(),
      ),
    );
  }
}
