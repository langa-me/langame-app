import 'dart:ui';

import 'package:flutter/material.dart';

class ArrowPainter extends CustomPainter {
  ArrowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    var path = Path();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    paint.color = Colors.black;
    path.moveTo(size.width, 0);
    path.quadraticBezierTo(size.width * 0.90, size.height * 0.30,
        size.width * 0.62, size.height * 0.36);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.45,
        size.width * 0.18, size.height * 0.70);
    path.moveTo(size.width * 0.09, size.height * 0.67);
    path.quadraticBezierTo(size.width * 0.14, size.height * 0.68,
        size.width * 0.17, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.22, size.height * 0.68,
        size.width * 0.28, size.height * 0.67);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
