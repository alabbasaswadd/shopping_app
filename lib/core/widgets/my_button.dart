import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/widgets/my_text.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColor.kPrimaryColor,
    this.textColor = Colors.white,
    this.isLoading = false,
    this.borderRadius = 12.0,
    this.height = 50.0,
    this.elevation = 0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    this.icon,
    this.iconAlignment = MainAxisAlignment.center,
  });

  final text;
  final Function() onPressed;
  final Color color;
  final Color textColor;
  final bool isLoading;
  final double borderRadius;
  final double height;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final Widget? icon;
  final MainAxisAlignment iconAlignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        elevation: elevation,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: Colors.white.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: LinearGradient(
                colors: [
                  color,
                  Color.lerp(color, Colors.black, 0.1)!,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedOpacity(
                  opacity: isLoading ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Row(
                    mainAxisAlignment: iconAlignment,
                    children: [
                      if (icon != null) ...[
                        icon!,
                        const SizedBox(width: 8),
                      ],
                      CairoText(
                        text,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                if (isLoading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
