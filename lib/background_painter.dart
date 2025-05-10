import 'dart:math' as math;

import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  final double animation;
  final Color color1;
  final Color color2;
  final Color color3;

  BackgroundPainter({
    super.repaint,
    required this.animation,
    required this.color1,
    required this.color2,
    required this.color3,
  });

  @override
  void paint(Canvas canva, Size size) {
    final paint =
        Paint()
          ..style = PaintingStyle.fill
          ..blendMode = BlendMode.srcOver;

    final blob1Path = Path();
    final centerX1 = size.width * 0.25;
    final centerY1 = size.height * 0.2;
    final radius1 = size.width * 0.4;

    for (int i = 0; i < 360; i += 5) {
      final rad = i * math.pi / 180;
      final noise = 0.2 * math.sin(animation * math.pi * 2 + rad * 3);
      final adjustedRadius = radius1 * (1 + noise);
      final x = centerX1 + adjustedRadius * math.cos(rad);
      final y = centerY1 + adjustedRadius * math.sin(rad);

      if (i == 0) {
        blob1Path.moveTo(x, y);
      } else {
        blob1Path.lineTo(x, y);
      }
    }

    blob1Path.close();

    paint.color = color1;
    canva.drawPath(blob1Path, paint);

    final blob2Path = Path();
    final centerX2 = size.width * 0.7;
    final centerY2 = size.height * 0.65;
    final radius2 = size.width * 0.35;

    for (int i = 0; i < 360; i += 5) {
      final rad = i * math.pi / 180;
      final noise = 0.2 * math.sin(animation * math.pi * 2 + rad * 4 + math.pi);
      final adjustedRadius = radius2 * (1 + noise);
      final x = centerX2 + adjustedRadius * math.cos(rad);
      final y = centerY2 + adjustedRadius * math.sin(rad);

      if (i == 0) {
        blob2Path.moveTo(x, y);
      } else {
        blob2Path.lineTo(x, y);
      }
    }

    blob2Path.close();

    paint.color = color2;
    canva.drawPath(blob2Path, paint);

    final blob3Path = Path();
    final centerX3 = size.width * 0.8;
    final centerY3 = size.height * 0.15;
    final radius3 = size.width * 0.25;

    for (int i = 0; i < 360; i += 5) {
      final rad = i * math.pi / 180;
      final noise =
          0.2 * math.sin(animation * math.pi * 2 + rad * 5 + math.pi / 2);
      final adjustedRadius = radius3 * (1 + noise);
      final x = centerX3 + adjustedRadius * math.cos(rad);
      final y = centerY3 + adjustedRadius * math.sin(rad);

      if (i == 0) {
        blob3Path.moveTo(x, y);
      } else {
        blob3Path.lineTo(x, y);
      }
    }

    blob3Path.close();

    paint.color = color3;
    canva.drawPath(blob3Path, paint);
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) =>
      oldDelegate.animation != animation;
}
