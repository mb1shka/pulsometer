import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MeasurementPainter extends CustomPainter {

  late Size size;
  late Canvas canvas;
  late Offset center;
  late Paint paintObj;


  @override
  void paint(Canvas canvas, Size size) {
    _init(canvas, size);
    _drawInnerCircle();
    _drawHeart();
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

  void _drawInnerCircle() {
    //внутренний круг
    paintObj
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    canvas.drawCircle(size.center(Offset.zero), size.width / 1.38, paintObj);
  }

  void _drawHeart() {
    paintObj
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;

    Paint paint1 = Paint();
    paint1
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    double width = size.width;
    double height = size.height;

    Path path = Path();
    path.moveTo(0.5 * width, height * 0.35);
    path.cubicTo(0.2 * width, height * 0.1, -0.25 * width, height * 0.6,
        0.5 * width, height);
    path.moveTo(0.5 * width, height * 0.35);
    path.cubicTo(0.8 * width, height * 0.1, 1.25 * width, height * 0.6,
        0.5 * width, height);

    canvas.drawPath(path, paint1);
    canvas.drawPath(path, paintObj);
  }

}