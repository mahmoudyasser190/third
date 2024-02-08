import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/models/lesson.dart';
import '../../../../core/services/audio_service.dart';
import '../../../../core/services/cache_service.dart';
import '../../lesson_page_controller.dart';
import 'models/draw_point.dart';

class WhiteBoardSectionController extends GetxController {
  final Lesson lesson;
  final CacheService cacheService;
  final AudioService audioService;

  WhiteBoardSectionController({
    required this.lesson,
    required this.cacheService,
    required this.audioService,
  });

  static const List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.black,
  ];

  late final RxInt selectedColorIndex;

  late final RxList<DrawingPoint> historyDrawingPoints;
  late final RxList<DrawingPoint> drawingPoints;
  late Rxn<DrawingPoint> currentDrawingPoint;
  late final RxDouble selectedDrawingWidth;

  @override
  void onInit() {
    selectedColorIndex = 0.obs;
    historyDrawingPoints = <DrawingPoint>[].obs;
    drawingPoints = <DrawingPoint>[].obs;
    currentDrawingPoint = Rxn<DrawingPoint>();
    selectedDrawingWidth = (1.0).obs;
    _initDrawingWidth();
    super.onInit();
  }

  Future<void> _initDrawingWidth() async {
    final double drawingWidth = (await cacheService.getKey<double>('drawingWidth')) ?? 1;
    selectedDrawingWidth.value = drawingWidth;
  }

  void updateSelectedColor(int newColorIndex) => selectedColorIndex.value = newColorIndex;

  void updateCurrentDrawingPoint(DrawingPoint? newDrawingPoint) => currentDrawingPoint.value = newDrawingPoint;

  void addDrawingPoint(DrawingPoint drawingPoint, {bool atTheEnd = false}) {
    atTheEnd ? drawingPoints.last = drawingPoint : drawingPoints.add(drawingPoint);
    historyDrawingPoints.value = List.of(drawingPoints);
  }

  Future<void> updateSelectedDrawingWidth(double newValue) async {
    selectedDrawingWidth.value = newValue;
    await cacheService.setKey<double>('drawingWidth', newValue);
  }

  void clearBoard() => drawingPoints.value = <DrawingPoint>[];

  void undo() {
    if (drawingPoints.isNotEmpty && historyDrawingPoints.isNotEmpty) {
      drawingPoints.removeLast();
    }
  }

  void redo() {
    if (drawingPoints.length < historyDrawingPoints.length) {
      // 6 length 7
      final index = drawingPoints.length;
      drawingPoints.add(historyDrawingPoints[index]);
    }
  }

  Future<void> completeLesson() async {
    final bool isLessonPageControllerRegistered = Get.isRegistered<LessonPageController>();
    if (isLessonPageControllerRegistered) {
      final LessonPageController lessonPageController = Get.find<LessonPageController>();
      await lessonPageController.completeLesson();
    }
  }
}
