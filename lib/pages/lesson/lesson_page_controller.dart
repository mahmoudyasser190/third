import '../../core/constants/routes.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../core/models/lesson.dart';
import '../../core/services/audio_service.dart';
import '../home/home_page_controller.dart';
import '../home/widgets/lessons_list/lessons_list_controller.dart';
import '../home/widgets/lessons_list/widgets/lesson_card.dart';

class LessonPageController extends GetxController {
  final Color color;
  final Lesson lesson;
  final AudioService audioService;
  final VoidCallback? onWillPop;

  LessonPageController({
    required this.lesson,
    required this.audioService,
    required this.color,
    this.onWillPop,
  });

  late final ConfettiController confettiController;

  late final Rx<LessonState> lessonState;

  @override
  onInit() {
    confettiController = ConfettiController(duration: 5.seconds);
    lessonState = LessonState.active.obs;
    super.onInit();
  }

  Future<void> playLessonContent() async => await audioService.playLessonContent(lesson);

  Future<void> completeLesson() async {
    lessonState.value = LessonState.completed;
    confettiController.play();
    await audioService.playLessonCompletionMusic();
    final bool isLessonListControllerRegistered = Get.isRegistered<LessonsListController>();
    if (isLessonListControllerRegistered) {
      final LessonsListController lessonsListController = Get.find<LessonsListController>();
      final Lesson activeLesson = lessonsListController.activeLesson.value;
      if (lesson == activeLesson) {
        await lessonsListController.activateNextLesson();
      }
    }
    await Future.delayed(confettiController.duration);
    Get.back();
    final bool isHomePageControllerRegistered = Get.isRegistered<HomePageController>();
    if (isHomePageControllerRegistered) {
      final HomePageController homePageController = Get.find<HomePageController>();
      await homePageController.playbackgroundMusic();
    }
  }

  void openPuzzlePage() => Get.toNamed(AppRoutes.puzzle);

  @override
  void onClose() {
    confettiController.dispose();
    super.onClose();
  }
}
