import '../models/lesson.dart';

enum AudioServiceState { playing, paused, stopped }

abstract class AudioService {
  Future<void> init();
  Stream<AudioServiceState> stateSubscription();
  Stream<void> onComplete();
  Future<void> playBackgroundMusic();
  Future<void> pauseBackgroundMusic();
  Future<void> playLessonContent(Lesson lesson);
  Future<void> playLessonCompletionMusic();
  Future<void> playWrongChoiceEffect();
}
