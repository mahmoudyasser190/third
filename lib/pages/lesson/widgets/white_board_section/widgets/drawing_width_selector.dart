import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawingWidthSelector extends StatelessWidget {
  final double selectedWidth;
  final Color color;
  final Function(double) onChanged;

  const DrawingWidthSelector({
    required this.selectedWidth,
    required this.color,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.width > 500 ? 48 : 32,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Slider(
        min: 1,
        max: 25,
        activeColor: color,
        thumbColor: color,
        inactiveColor: Colors.white,
        value: selectedWidth,
        onChanged: onChanged,
      ),
    );
  }
}
