import 'package:flutter/material.dart';

/// A custom painter that draws the background bar with a cutout notch.
/// Optimized to use a single continuous path for better performance.
class NotchPainter extends CustomPainter {
  final double notchRadius;
  final double notchPosition;
  final Color color;
  final bool showTopRadius;
  final bool showBottomRadius;
  final double elevation;

  const NotchPainter({
    required this.notchRadius,
    required this.notchPosition,
    required this.color,
    this.showTopRadius = true,
    this.showBottomRadius = true,
    this.elevation = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Use a single continuous path to avoid expensive Path.combine operations
    final path = Path();
    const double cornerRadius = 20.0;
    final double notchWidth = notchRadius * 3.5;
    final double halfNotchWidth = notchWidth / 2;
    final double startNotch = notchPosition - halfNotchWidth;
    final double endNotch = notchPosition + halfNotchWidth;

    // Start from top-left corner
    if (showTopRadius) {
      path.moveTo(0, cornerRadius);
      path.quadraticBezierTo(0, 0, cornerRadius, 0);
    } else {
      path.moveTo(0, 0);
    }

    // Line to start of notch
    path.lineTo(startNotch, 0);

    // Notch curve (smooth cutout)
    path.cubicTo(
      startNotch + notchWidth * 0.2,
      0,
      notchPosition - notchRadius * 0.8,
      notchRadius * 1.2,
      notchPosition,
      notchRadius * 1.2,
    );
    path.cubicTo(
      notchPosition + notchRadius * 0.8,
      notchRadius * 1.2,
      endNotch - notchWidth * 0.2,
      0,
      endNotch,
      0,
    );

    // Line to top-right corner
    if (showTopRadius) {
      path.lineTo(size.width - cornerRadius, 0);
      path.quadraticBezierTo(size.width, 0, size.width, cornerRadius);
    } else {
      path.lineTo(size.width, 0);
    }

    // Line to bottom-right corner
    if (showBottomRadius) {
      path.lineTo(size.width, size.height - cornerRadius);
      path.quadraticBezierTo(
          size.width, size.height, size.width - cornerRadius, size.height);
    } else {
      path.lineTo(size.width, size.height);
    }

    // Line to bottom-left corner
    if (showBottomRadius) {
      path.lineTo(cornerRadius, size.height);
      path.quadraticBezierTo(0, size.height, 0, size.height - cornerRadius);
    } else {
      path.lineTo(0, size.height);
    }

    path.close();

    // Draw shadow if needed
    if (elevation > 0) {
      canvas.drawShadow(
          path, Colors.black.withValues(alpha: 0.5), elevation, true);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant NotchPainter oldDelegate) {
    return oldDelegate.notchPosition != notchPosition ||
        oldDelegate.color != color ||
        oldDelegate.notchRadius != notchRadius ||
        oldDelegate.showTopRadius != showTopRadius ||
        oldDelegate.showBottomRadius != showBottomRadius;
  }
}
