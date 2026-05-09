import 'package:flutter/material.dart';

/// A custom painter that draws the background bar with the cutout notch.
class NotchPainter extends CustomPainter {
  final double notchRadius;
  final double notchPosition;
  final Color color;
  final bool showTopRadius;
  final bool showBottomRadius;
  final double elevation;

  NotchPainter({
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

    // 1. Create a perfect Rounded Rect for the base bar
    final barPath = Path()
      ..addRRect(RRect.fromLTRBAndCorners(
        0,
        0,
        size.width,
        size.height,
        topLeft: Radius.circular(showTopRadius ? 20 : 0),
        topRight: Radius.circular(showTopRadius ? 20 : 0),
        bottomLeft: Radius.circular(showBottomRadius ? 20 : 0),
        bottomRight: Radius.circular(showBottomRadius ? 20 : 0),
      ));

    // 2. Create the Notch Cutout Path
    final notchPath = Path();
    final double notchWidth = notchRadius * 3.5;
    final double startNotch = notchPosition - notchWidth / 2;
    final double endNotch = notchPosition + notchWidth / 2;

    notchPath.moveTo(startNotch, -1); // Start slightly above to ensure clean cut
    notchPath.lineTo(startNotch, 0);

    notchPath.cubicTo(
      startNotch + notchWidth * 0.2,
      0,
      notchPosition - notchRadius * 0.8,
      notchRadius * 1.2,
      notchPosition,
      notchRadius * 1.2,
    );
    notchPath.cubicTo(
      notchPosition + notchRadius * 0.8,
      notchRadius * 1.2,
      endNotch - notchWidth * 0.2,
      0,
      endNotch,
      0,
    );
    notchPath.lineTo(endNotch, -1);
    notchPath.close();

    // 3. Subtract Notch from Bar
    final finalPath = Path.combine(PathOperation.difference, barPath, notchPath);

    if (elevation > 0) {
      canvas.drawShadow(finalPath, Colors.black.withValues(alpha: 0.5), elevation, true);
    }

    canvas.drawPath(finalPath, paint);
  }

  @override
  bool shouldRepaint(covariant NotchPainter oldDelegate) {
    return oldDelegate.notchPosition != notchPosition ||
        oldDelegate.color != color ||
        oldDelegate.notchRadius != notchRadius;
  }
}
