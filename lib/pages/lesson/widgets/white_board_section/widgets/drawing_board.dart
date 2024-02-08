import 'package:flutter/material.dart';

import '../models/draw_point.dart';
import '../painters/drawing_painter.dart';

class DrawingBoard extends StatelessWidget {
  final Function(DragStartDetails) onPanStart;
  final Function(DragUpdateDetails) onPanUpdate;
  final Function(DragEndDetails) onPanEnd;
  final List<DrawingPoint> drawingPoints;

  const DrawingBoard({
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.drawingPoints,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: CustomPaint(
        painter: DrawingPainter(drawingPoints: drawingPoints),
        child: const SizedBox(width: double.maxFinite, height: double.maxFinite),
      ),
    );
  }
}
