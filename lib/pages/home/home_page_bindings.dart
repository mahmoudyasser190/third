import '../../core/services/audio_service.dart';
import '../../core/services/cache_service.dart';
import 'widgets/lessons_list/lessons_list_controller.dart';
import 'home_page_controller.dart';
import 'package:get/get.dart';

class HomePageBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<HomePageController>(HomePageController(audioService: Get.find<AudioService>()));
    Get.put<LessonsListController>(LessonsListController(cacheService: Get.find<CacheService>()));
  }
}
