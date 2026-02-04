import 'dart:ui';
import 'package:flutter/material.dart';
import '../../models/emotion.dart';
import '../../theme/check_in_colors.dart';

/// Single emotion bubble for the draggable grid. Same morphing style as category buttons.
/// Reusable: used in grid chart only.
class MorphingEmotion extends StatefulWidget {
  final Emotion emotion;
  final VoidCallback onTap;

  const MorphingEmotion({
    super.key,
    required this.emotion,
    required this.onTap,
  });

  @override
  State<MorphingEmotion> createState() => _MorphingEmotionState();
}

class _MorphingEmotionState extends State<MorphingEmotion>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _rotation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.05), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 0.95), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.02), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.02, end: 1.0), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = CheckInColors.paletteForType(widget.emotion.type);
    const size = 140.0;

    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: Listenable.merge([_rotation, _scale]),
        builder: (context, child) {
          return Transform.scale(
            scale: _scale.value,
            child: Transform.rotate(
              angle: _rotation.value * 2 * 3.14159,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer blur layer
                  Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [palette.primary, palette.secondary],
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(size / 2),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                        child: Container(
                          color: Colors.white.withOpacity(0.08),
                        ),
                      ),
                    ),
                  ),
                  // Inner solid
                  Container(
                    width: size * 0.88,
                    height: size * 0.88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [palette.accent, palette.primary],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.emotion.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        shadows: [
                          Shadow(
                            color: palette.glow.withOpacity(0.6),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Glow ring
                  Container(
                    width: size + 16,
                    height: size + 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: palette.glow.withOpacity(0.25),
                        width: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
