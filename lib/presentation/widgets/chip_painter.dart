import 'package:flutter/cupertino.dart';

class ChipPainter extends CustomPainter {
  late Size size;
  late Canvas canvas;
  late Offset center;
  late Paint paintObj;


  @override
  void paint(Canvas canvas, Size size) {
    _init(canvas, size);
    _drawRoundedRectangle();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _init(Canvas canvas, Size size) {
    this.canvas = canvas;
    this.size = size;
    center = size.center(Offset.zero);
    paintObj = Paint();
  }

  void _drawRoundedRectangle() {
    paintObj
      ..color = Color.fromRGBO(255, 241, 243, 1)
      ..style = PaintingStyle.fill;

    final a = Offset(0, size.height);
    final b = Offset(size.width, 0);
    final rect = Rect.fromPoints(a, b);
    final Radius radius = Radius.circular(24);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), paintObj);
  }
}