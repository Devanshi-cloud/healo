import 'dart:ui';
import 'package:flutter/material.dart';

/// Morphing wave-style button for the 2x2 mood category selection.
/// Reusable: used only on the main check-in step.
/// Preserves calm, reflective tone with soft gradients and gentle motion.
class MorphingWaveButton extends StatefulWidget {
  final String text;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color glow;
  final VoidCallback onTap;

  const MorphingWaveButton({
    super.key,
    required this.text,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.glow,
    required this.onTap,
  });

  @override
  State<MorphingWaveButton> createState() => _MorphingWaveButtonState();
}

class _MorphingWaveButtonState extends State<MorphingWaveButton>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _glowController;
  late Animation<double> _waveRotation;
  late Animation<double> _waveScale1;
  late Animation<double> _waveScale2;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _glowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _waveRotation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.linear),
    );
    _waveScale1 = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.05), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 0.95), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.02), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.02, end: 1.0), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.easeInOut),
    );
    _waveScale2 = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.98, end: 1.03), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.03, end: 0.97), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.97, end: 1.01), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.01, end: 0.98), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _waveController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const size = 160.0;
          return SizedBox(
            width: size,
            height: size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer glow ring (rotating conic gradient)
                AnimatedBuilder(
                  animation: _waveController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _waveRotation.value * 2 * 3.14159,
                      child: Container(
                        width: size + 24,
                        height: size + 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: widget.glow.withOpacity(0.2),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: CustomPaint(
                          painter: _ConicGlowPainter(
                            colors: [
                              widget.primary,
                              widget.secondary,
                              widget.accent,
                              widget.glow,
                              widget.primary,
                            ],
                          ),
                          size: Size(size + 24, size + 24),
                        ),
                      ),
                    );
                  },
                ),
                // Layer 1 - outer blur
                AnimatedBuilder(
                  animation: _waveController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _waveRotation.value * 2 * 3.14159,
                      child: Transform.scale(
                        scale: _waveScale1.value,
                        child: Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [widget.primary, widget.secondary],
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(size / 2),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                              child: Container(
                                color: Colors.white.withOpacity(0.1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // Layer 2 - middle
                AnimatedBuilder(
                  animation: _waveController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: -_waveRotation.value * 2 * 3.14159 * 0.8,
                      child: Transform.scale(
                        scale: _waveScale2.value,
                        child: Container(
                          width: size * 0.92,
                          height: size * 0.92,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [widget.secondary, widget.accent],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // Layer 3 - inner solid + text
                Container(
                  width: size * 0.85,
                  height: size * 0.85,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [widget.accent, widget.primary],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.glow.withOpacity(0.4),
                        blurRadius: 16,
                        spreadRadius: -4,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: AnimatedBuilder(
                    animation: _glowController,
                    builder: (context, child) {
                      return Text(
                        widget.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              color: widget.glow.withOpacity(
                                  0.6 + 0.2 * _glowController.value),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ConicGlowPainter extends CustomPainter {
  final List<Color> colors;

  _ConicGlowPainter({required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final gradient = SweepGradient(
      startAngle: 0,
      endAngle: 2 * 3.14159,
      colors: colors,
    ).createShader(rect);
    final paint = Paint()
      ..shader = gradient
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2 - 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
