// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:game_ui/game_ui.dart';
import 'package:get/get.dart';

import '../../../../core/constants/fonts.dart';
import 'models/draw_point.dart';
import 'white_board_section_controller.dart';
import 'widgets/colors_row.dart';
import 'widgets/complete_lesson_button.dart';
import 'widgets/drawing_board.dart';
import 'widgets/drawing_width_selector.dart';
import 'widgets/edit_drawing_buttons.dart';

class WhiteBoardSection extends GetView<WhiteBoardSectionController> {
  const WhiteBoardSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = context.width;
    final Widget colorsRow = ObxValue<RxInt>(
      (RxInt rxSelectedColorIndex) {
        return ColorsRow(
          colors: WhiteBoardSectionController.colors,
          selectedColorIndex: rxSelectedColorIndex.value,
          onColorSelected: controller.updateSelectedColor,
        );
      },
      controller.selectedColorIndex,
    );
    final Widget widthSelector = ObxValue<RxInt>(
      (RxInt rxSelectedColorIndex) {
        final int selectedColorIndex = rxSelectedColorIndex.value;
        final Color color = WhiteBoardSectionController.colors[selectedColorIndex];
        return ObxValue<RxDouble>(
          (RxDouble rxSelectedWidth) {
            return DrawingWidthSelector(
              selectedWidth: rxSelectedWidth.value,
              color: color,
              onChanged: controller.updateSelectedDrawingWidth,
            );
          },
          controller.selectedDrawingWidth,
        );
      },
      controller.selectedColorIndex,
    );
    final Widget drawingHistoryButtons = ObxValue(
      (RxList<DrawingPoint> rxDrawingPointsHistory) {
        final List<DrawingPoint> drawingPointsHistory = rxDrawingPointsHistory.value;
        return ObxValue(
          (RxList<DrawingPoint> rxDrawingPoints) {
            final List<DrawingPoint> drawingPoints = rxDrawingPoints.value;
            return EditDrawingButtons(
              onUndo: controller.undo,
              onRedo: controller.redo,
              onClear: controller.clearBoard,
              isUndoEnabled: drawingPoints.isNotEmpty,
              isRedoEnabled: drawingPointsHistory.length > drawingPoints.length,
              isClearEnabled: drawingPoints.isNotEmpty,
            );
          },
          controller.drawingPoints,
        );
      },
      controller.historyDrawingPoints,
    );
    final Widget compeleteLessonButton = CompleteLessonButton(onTap: controller.completeLesson);
    return GameCard(
      width: double.maxFinite,
      height: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: width > 500 ? 16 : 8),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: FittedBox(
                    alignment: Alignment.center,
                    child: Text(
                      controller.lesson.number.toString(),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: AppFonts.quicksandDash,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: ObxValue<Rxn<DrawingPoint>>(
                    (Rxn<DrawingPoint> rxCurrentDrawingPoint) {
                      final DrawingPoint? currentDrawingPoint = rxCurrentDrawingPoint.value;
                      return ObxValue<RxDouble>(
                        (RxDouble rxSelectedDrawingWidth) {
                          final double selectedWidth = rxSelectedDrawingWidth.value;
                          return ObxValue<RxInt>(
                            (RxInt rxSelectedColorIndex) {
                              const List<Color> colors = WhiteBoardSectionController.colors;
                              final int selectedColorIndex = rxSelectedColorIndex.value;
                              final Color selectedColor = colors[selectedColorIndex];
                              return ObxValue(
                                (RxList<DrawingPoint> rxDrawingPoints) {
                                  final List<DrawingPoint> drawingPoints = rxDrawingPoints.value;
                                  return DrawingBoard(
                                    onPanStart: (DragStartDetails details) {
                                      final DrawingPoint newCurrentDrawingPoint = DrawingPoint(
                                        id: DateTime.now().microsecondsSinceEpoch,
                                        offsets: [details.localPosition],
                                        color: selectedColor,
                                        width: selectedWidth,
                                      );
                                      controller.updateCurrentDrawingPoint(newCurrentDrawingPoint);
                                      controller.addDrawingPoint(newCurrentDrawingPoint);
                                    },
                                    onPanUpdate: (DragUpdateDetails details) {
                                      if (currentDrawingPoint == null) return;
                                      final newCurrentDrawingPoint = currentDrawingPoint.copyWith(
                                        offsets: currentDrawingPoint.offsets..add(details.localPosition),
                                      );
                                      controller.updateCurrentDrawingPoint(newCurrentDrawingPoint);
                                      controller.addDrawingPoint(newCurrentDrawingPoint, atTheEnd: true);
                                    },
                                    onPanEnd: (DragEndDetails details) => controller.updateCurrentDrawingPoint(null),
                                    drawingPoints: drawingPoints,
                                  );
                                },
                                controller.drawingPoints,
                              );
                            },
                            controller.selectedColorIndex,
                          );
                        },
                        controller.selectedDrawingWidth,
                      );
                    },
                    controller.currentDrawingPoint,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          if (width > 1200)
            Row(
              children: [
                Expanded(flex: 2, child: colorsRow),
                Flexible(child: widthSelector),
                const SizedBox(width: 16),
                drawingHistoryButtons,
                const SizedBox(width: 16),
                compeleteLessonButton,
              ],
            ),
          if (width <= 1200)
            Column(
              children: [
                colorsRow,
                SizedBox(height: width > 500 ? 16 : 8),
                Row(
                  children: [
                    Flexible(child: widthSelector),
                    if (width >= 660 || (width < 600 && !(width < 450))) ...[
                      const SizedBox(width: 16),
                      drawingHistoryButtons,
                      const SizedBox(width: 16),
                      compeleteLessonButton,
                    ],
                  ],
                ),
                SizedBox(height: width > 500 ? 16 : 8),
                if ((width < 660 && width > 600) || (width < 450))
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      drawingHistoryButtons,
                      const SizedBox(width: 16),
                      compeleteLessonButton,
                    ],
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
