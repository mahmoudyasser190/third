import 'package:flutter/material.dart';
import 'package:game_ui/game_ui.dart';
import 'package:get/get.dart';

class ColorsRow extends StatelessWidget {
  final List<Color> colors;
  final int selectedColorIndex;
  final Function(int) onColorSelected;

  const ColorsRow({
    required this.colors,
    required this.selectedColorIndex,
    required this.onColorSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonSize = context.width > 500 ? 48 : 32;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: colors.map<Widget>(
        (Color color) {
          final int colorIndex = colors.indexOf(color);
          final bool isSelected = selectedColorIndex == colorIndex;
          return GestureDetector(
            onTap: () => onColorSelected(colorIndex),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isSelected) ...[
                  Container(
                    height: buttonSize * 1.05,
                    width: buttonSize * 1.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: buttonSize * 1.1,
                    width: buttonSize * 1.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: color,
                    ),
                  ),
                ],
                ColorButton(
                  height: buttonSize,
                  width: buttonSize,
                  color: color,
                  shadowColor: Colors.black.withOpacity(0.15),
                  borderColor: Colors.white,
                  borderThickness: 2,
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
