import 'package:flutter/cupertino.dart';
import 'package:heart_rate/presentation/widgets/measurement_painter.dart';

class MeasurementStart extends StatelessWidget {

  final double size;

  MeasurementStart({
    this.size = 200
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: MeasurementPainter(),
    );
  }
}