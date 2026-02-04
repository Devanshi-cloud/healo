import 'dart:ui';
import 'package:flutter/material.dart';

/// Animated gradient background for the description step.
/// Reusable: can be used on any reflective/calm screen.
/// Uses multiple animated gradient layers to approximate the React BackgroundGradientAnimation.
class DescriptionGradientBackground extends StatefulWidget {
  final Widget child;
  final bool isDark;

  const DescriptionGradientBackground({
    super.key,
    required this.child,
    this.isDark = false,
  });

  @override
  State<DescriptionGradientBackground> createState() =>
      _DescriptionGradientBackgroundState();
}

class _DescriptionGradientBackgroundState
    extends State<DescriptionGradientBackground> with TickerProviderStateMixin {
  late AnimationController _shimmerController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base =
        widget.isDark ? const Color(0xFF050505) : const Color(0xFFF0F0F0);

    return AnimatedBuilder(
      animation: Listenable.merge([_shimmerController, _pulseController]),
      builder: (context, child) {
        return Stack(
          fit: StackFit.expand,
          children: [
            // Base gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    base,
                    base.withOpacity(0.92),
                  ],
                ),
              ),
            ),
            // Animated color orbs (soft, calm)
            Positioned(
              left: -80 + 60 * _shimmerController.value,
              top: 100,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF1271FF).withOpacity(0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: -60 + 40 * (1 - _shimmerController.value),
              top: 200,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFBD00FF).withOpacity(0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 40,
              bottom: 150,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF00C4E3).withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Blur overlay for depth
            Positioned.fill(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                  child: Container(color: Colors.transparent),
                ),
              ),
            ),
            child!,
          ],
        );
      },
      child: widget.child,
    );
  }
}
