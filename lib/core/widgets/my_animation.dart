import 'package:flutter/material.dart';

class MyAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Duration duration;
  final double scale;
  final BorderRadius? borderRadius;

  const MyAnimation({
    super.key,
    required this.child,
    this.onTap,
    this.duration = const Duration(milliseconds: 100),
    this.scale = 0.95,
    this.borderRadius,
  });

  @override
  State<MyAnimation> createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation> {
  double _currentScale = 1.0;

  void _onTapDown(TapDownDetails _) {
    setState(() => _currentScale = widget.scale);
  }

  void _onTapUp(TapUpDetails _) {
    setState(() => _currentScale = 1.0);
  }

  void _onTapCancel() {
    setState(() => _currentScale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _currentScale,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: ClipRRect(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
          child: widget.child,
        ),
      ),
    );
  }
}
