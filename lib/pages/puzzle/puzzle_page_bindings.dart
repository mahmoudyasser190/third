import '../../core/services/audio_service.dart';
import 'puzzle_page_controller.dart';
import 'package:get/get.dart';

class PuzzlePageBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<PuzzlePageController>(PuzzlePageController(audioService: Get.find<AudioService>()));
  }
}
