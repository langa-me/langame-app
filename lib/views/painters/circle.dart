import 'package:flutter/material.dart';

class DrawCircle extends CustomPainter {
  late Paint _paint;
  double diameter;

  DrawCircle({this.diameter = 5}) {
    _paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, 0.0), diameter, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
