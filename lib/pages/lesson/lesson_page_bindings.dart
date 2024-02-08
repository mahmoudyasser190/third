import 'package:get/get.dart';

import '../../core/services/audio_service.dart';
import '../../core/services/cache_service.dart';
import 'lesson_page_arguments.dart';
import 'lesson_page_controller.dart';
import 'widgets/white_board_section/white_board_section_controller.dart';

class LessonPageBindings extends Bindings {
  @override
  void dependencies() {
    final AudioService audioService = Get.find<AudioService>();
    final LessonPageArguments arguments = Get.arguments;
    final LessonPageController controller = LessonPageController(
      audioService: audioService,
      lesson: arguments.lesson,
      onWillPop: arguments.onWillPop,
      color: arguments.color,
    );
    Get.put<LessonPageController>(controller);
    Get.put<WhiteBoardSectionController>(
      WhiteBoardSectionController(
        lesson: arguments.lesson,
        audioService: audioService,
        cacheService: Get.find<CacheService>(),
      ),
    );
  }
}
