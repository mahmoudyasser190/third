import 'dart:async';

import 'package:get/get.dart';

import '../../core/services/audio_service.dart';

class HomePageController extends GetxController {
  final AudioService audioService;

  HomePageController({required this.audioService});

  /// This is used to be notified when the audio service finishs playing audio
  /// so that we can play the background music again and make the loop effect
  late final StreamSubscription<void> onAudioServiceCompletion;

  @override
  void onInit() {
    playbackgroundMusic();
    // Looping the background music
    onAudioServiceCompletion = audioService.onComplete().listen((event) => playbackgroundMusic());
    super.onInit();
  }

  Future<void> playbackgroundMusic() async => await audioService.playBackgroundMusic();

  Future<void> pauseBackgroundMusic() async => await audioService.pauseBackgroundMusic();

  @override
  void onClose() {
    onAudioServiceCompletion.cancel();
    super.onClose();
  }
}
