import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String hintText;
  final IconData? prefixIcon;
  final Color? dropdownColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color borderColor;
  final double iconSize;
  final TextStyle? hintStyle;
  final TextStyle? itemStyle;
  final MainAxisAlignment? itemAlignment;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText = 'select_option',
    this.prefixIcon,
    this.dropdownColor,
    this.borderRadius = 12,
    this.padding,
    this.borderColor = Colors.transparent,
    this.iconSize = 28,
    this.hintStyle,
    this.itemStyle,
    this.itemAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15),
      ),
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColor.kPrimaryColor,
            size: iconSize,
          ),
          elevation: 2,
          dropdownColor: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(borderRadius),
          style: itemStyle ??
              TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
              ),
          hint: Row(
            children: [
              if (prefixIcon != null) ...[
                Icon(prefixIcon, color: AppColor.kPrimaryColor),
                const SizedBox(width: 12),
              ],
              Text(
                hintText,
                style: hintStyle ?? TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item.value,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: itemAlignment ?? MainAxisAlignment.start,
                  children: [
                    item.child,
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
