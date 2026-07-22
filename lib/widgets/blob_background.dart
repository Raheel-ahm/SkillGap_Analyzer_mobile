import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme.dart';

/// Geometric grid background used across auth screens
class GeometricBackground extends StatelessWidget {
  final Widget child;
  const GeometricBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: AppTheme.bgLight),
        CustomPaint(
          painter: _GeoPainter(),
          child: const SizedBox.expand(),
        ),
        child,
      ],
    );
  }
}

class _GeoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final linePaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Dot grid
    final dotPaint = Paint()..color = const Color(0xFFCBD5E1);
    const spacing = 32.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.2, dotPaint);
      }
    }

    // Diagonal accent lines top-right
    for (int i = 0; i < 6; i++) {
      final start = Offset(size.width - 60 + i * 12.0, 0);
      final end = Offset(size.width + 40.0, 100 + i * 12.0);
      canvas.drawLine(start, end, linePaint);
    }

    // Teal glow circle — top left
    final glowPaint = Paint()
      ..shader = const RadialGradient(
        colors: [
          Color(0x1A00A882),
          Color(0x0500A882),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(
          center: Offset(size.width * 0.1, size.height * 0.15), radius: 160));
    canvas.drawCircle(
        Offset(size.width * 0.1, size.height * 0.15), 160, glowPaint);

    // Amber glow — bottom right
    final amberPaint = Paint()
      ..shader = const RadialGradient(
        colors: [
          Color(0x15FF9800),
          Color(0x05FF9800),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(
          center: Offset(size.width * 0.9, size.height * 0.85), radius: 140));
    canvas.drawCircle(
        Offset(size.width * 0.9, size.height * 0.85), 140, amberPaint);

    // Hexagon outline — decorative
    _drawHex(
        canvas, Offset(size.width * 0.88, size.height * 0.18), 48, linePaint);
    _drawHex(canvas, Offset(size.width * 0.08, size.height * 0.78), 30,
        linePaint..color = const Color(0xFFE2E8F0));
  }

  void _drawHex(Canvas canvas, Offset center, double r, Paint paint) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (math.pi / 180) * (60 * i - 30);
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}

/// Card used inside auth screens
class DarkCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const DarkCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.borderDim),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Teal glow button
class GlowButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool loading;
  final Color? color;

  const GlowButton({
    super.key,
    required this.label,
    this.onTap,
    this.loading = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppTheme.purple;
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: c,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: c.withValues(alpha: 0.35),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: loading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                    color: AppTheme.white, strokeWidth: 2.5),
              )
            : Text(
                label,
                style: const TextStyle(
                  color: AppTheme.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
