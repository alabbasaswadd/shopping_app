import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';

class MyCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  final double elevation;
  final BorderRadius borderRadius;

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  final Color? color;
  final Gradient? gradient;
  final BoxBorder? border;
  final List<BoxShadow>? shadow;

  final bool enableRippleEffect;
  final Duration animationDuration;
  final Curve animationCurve;

  final bool enableAutoPulse;
  final Duration pulseDuration;
  final double pulseScaleFactor;

  final bool enableGradient;
  final bool enableShadow;

  /// تحكم إضافي في شدة الظل
  final double shadowIntensity;

  const MyCard({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.elevation = 4.0, // تقليل الارتفاع الافتراضي لمظهر أكثر أناقة
    this.borderRadius =
        const BorderRadius.all(Radius.circular(12)), // نصف قطر أقل لمظهر حديث
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(4.0),
    this.color,
    this.gradient,
    this.border,
    this.shadow,
    this.enableRippleEffect = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeOut,
    this.enableAutoPulse = false,
    this.pulseDuration = const Duration(milliseconds: 1500),
    this.pulseScaleFactor = 0.02,
    this.enableGradient = false, // تعطيل التدرج الافتراضي لمظهر أنظف
    this.enableShadow = true,
    this.shadowIntensity = 0.5,
  });

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.pulseDuration,
      vsync: this,
    );

    if (widget.enableAutoPulse) {
      _controller.repeat(reverse: true);
    }

    _scaleAnimation = Tween<double>(
      begin: 1.0 - widget.pulseScaleFactor,
      end: 1.0 + widget.pulseScaleFactor,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<BoxShadow> _buildShadow(BuildContext context) {
    if (!widget.enableShadow) return [];

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final intensity = widget.shadowIntensity.clamp(0.0, 1.0);

    return widget.shadow ??
        [
          if (isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.5 * intensity),
              blurRadius: widget.elevation * 1.5,
              spreadRadius: -1.0, // تقليل الانتشار لمظهر أكثر دقة
              offset: const Offset(0, 2),
            )
          else
            BoxShadow(
              color: Colors.black.withOpacity(0.15 * intensity),
              blurRadius: widget.elevation * 2,
              spreadRadius: -1.0,
              offset: const Offset(0, 2),
            ),
        ];
  }

  Color _getBackgroundColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return widget.color ??
        (isDark ? AppColor.kPrimaryColorDarkMode : Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = _getBackgroundColor(context);
    final effectiveShadow = _buildShadow(context);

    Widget cardContent = AnimatedContainer(
      duration: widget.animationDuration,
      curve: widget.animationCurve,
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        boxShadow: effectiveShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: widget.borderRadius,
            border: widget.border,
          ),
          child: InkWell(
            borderRadius: widget.borderRadius,
            onTap: widget.onTap,
            onLongPress: widget.onLongPress,
            splashColor: widget.enableRippleEffect
                ? theme.colorScheme.primary.withOpacity(0.08)
                : Colors.transparent,
            highlightColor: widget.enableRippleEffect
                ? theme.colorScheme.primary.withOpacity(0.04)
                : Colors.transparent,
            child: Padding(
              padding: widget.padding,
              child: widget.child,
            ),
          ),
        ),
      ),
    );

    if (widget.enableAutoPulse) {
      return AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: cardContent,
      );
    }

    return cardContent;
  }
}
