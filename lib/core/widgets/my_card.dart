import 'package:flutter/material.dart';

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

  final bool enableAutoPulse; // إضافة خاصية لتشغيل/إيقاف النبض التلقائي
  final Duration pulseDuration; // مدة دورة النبض الكاملة
  final double pulseScaleFactor; // مقدار التكبير/التصغير

  const MyCard({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.elevation = 6.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
    this.color,
    this.gradient,
    this.border,
    this.shadow,
    this.enableRippleEffect = true,
    this.animationDuration = const Duration(milliseconds: 250),
    this.animationCurve = Curves.easeInOut,
    this.enableAutoPulse = false,
    this.pulseDuration = const Duration(milliseconds: 1500),
    this.pulseScaleFactor = 0.02,
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
    )..repeat(reverse: true);

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = widget.color ?? theme.cardColor.withOpacity(0.95);

    final rippleColor = theme.colorScheme.primary.withOpacity(0.08);
    final highlightColor = theme.colorScheme.primary.withOpacity(0.04);

    final effectiveShadow = widget.shadow ??
        [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: widget.elevation * 2,
            spreadRadius: 0,
            offset: Offset(0, widget.elevation),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.6),
            blurRadius: widget.elevation,
            spreadRadius: 0,
            offset: Offset(0, -1),
          ),
        ];

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
            color: widget.gradient != null ? null : effectiveColor,
            gradient: widget.gradient ??
                LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    effectiveColor.withOpacity(1.0),
                    effectiveColor.withOpacity(0.92),
                  ],
                ),
            borderRadius: widget.borderRadius,
            border: widget.border,
          ),
          child: InkWell(
            borderRadius: widget.borderRadius,
            onTap: widget.onTap,
            onLongPress: widget.onLongPress,
            splashColor:
                widget.enableRippleEffect ? rippleColor : Colors.transparent,
            highlightColor:
                widget.enableRippleEffect ? highlightColor : Colors.transparent,
            child: Padding(
              padding: widget.padding,
              child: widget.child,
            ),
          ),
        ),
      ),
    );

    // تطبيق تأثير النبض التلقائي إذا كان مفعلاً
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
    } else {
      return cardContent;
    }
  }
}
