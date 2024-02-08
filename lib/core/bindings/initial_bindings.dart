import 'package:get/get.dart';
import '../services/audio_service.dart';
import '../services/cache_service.dart';

class InitialBindings extends Bindings {
  final CacheService cacheService;
  final AudioService audioService;

  InitialBindings({required this.cacheService, required this.audioService});

  @override
  void dependencies() {
    Get.put<CacheService>(cacheService);
    Get.put<AudioService>(audioService);
  }
}
