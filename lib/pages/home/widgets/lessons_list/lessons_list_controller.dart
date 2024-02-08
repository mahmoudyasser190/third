import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/models/lesson.dart';
import '../../../../core/services/cache_service.dart';
import '../../../lesson/lesson_page_arguments.dart';
import '../../home_page_controller.dart';

enum LessonsListState { loading, loaded, error }

class LessonsListController extends GetxController {
  final CacheService cacheService;

  LessonsListController({required this.cacheService});

  late final Rx<LessonsListState> state;
  late final Rx<Lesson> activeLesson;

  @override
  void onInit() {
    state = LessonsListState.loading.obs;
    activeLesson = Lesson.values.first.obs;
    _loadProgress();
    super.onInit();
  }

  Future<void> _loadProgress() async {
    try {
      state.value = LessonsListState.loading;
      final String activeLessonName = (await cacheService.getKey<String>('activeLesson')) ?? Lesson.values.first.name;
      final Lesson lastActiveLesson = Lesson.values.firstWhere(
        (lesson) => lesson.name == activeLessonName,
        orElse: () => Lesson.values.first,
      );
      activeLesson.value = lastActiveLesson;
      state.value = LessonsListState.loaded;
    } catch (e) {
      state.value = LessonsListState.error;
    }
  }

  Future<void> activateNextLesson() async {
    const List<Lesson> contentList = Lesson.values;
    final int currentLessonIndex = contentList.indexOf(activeLesson.value);
    if (currentLessonIndex != contentList.length - 1) {
      final Lesson nextLesson = contentList[currentLessonIndex + 1];
      activeLesson.value = nextLesson;
      await cacheService.setKey('activeLesson', nextLesson.name);
    }
  }

  Future<void> openLessonPage({required Lesson lesson, required Color color}) async {
    final bool isHomePageControllerRegistered = Get.isRegistered<HomePageController>();
    HomePageController? homePageController;
    if (isHomePageControllerRegistered) homePageController = Get.find<HomePageController>();
    await homePageController?.pauseBackgroundMusic();
    Get.toNamed(
      AppRoutes.lesson,
      arguments: LessonPageArguments(
        lesson: lesson,
        color: color,
        onWillPop: () async => await homePageController?.playbackgroundMusic(),
      ),
    );
  }

  Future<void> reset() async {
    final Lesson firstLesson = Lesson.values.first;
    activeLesson.value = firstLesson;
    await cacheService.setKey<String>('activeLesson', firstLesson.name);
  }
}
