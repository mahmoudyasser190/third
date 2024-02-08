import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import '../core/models/lesson.dart';
import '../core/services/audio_service.dart';

extension AudioPlayerShortcuts on AudioPlayer {
  bool get isPlaying => state == PlayerState.playing;
}

class AudioPlayersAudioService implements AudioService {
  late final AudioPlayer backgroundMusicAudioPlayer;
  late final AudioPlayer lessonAudioPlayer;
  late final AudioPlayer effectsAudioPlayer;

  @override
  Future<void> init() async {
    backgroundMusicAudioPlayer = AudioPlayer(playerId: 'backgroundMusicAudioPlayer');
    lessonAudioPlayer = AudioPlayer(playerId: 'lessonAudioPlayer');
    effectsAudioPlayer = AudioPlayer(playerId: 'effectsAudioPlayer');
  }

  @override
  Future<void> pauseBackgroundMusic() async => await backgroundMusicAudioPlayer.pause();

  Future<void> _playAsset(AudioPlayer player, String assetPath) async => await player.play(AssetSource('audio/$assetPath'));

  @override
  Future<void> playBackgroundMusic() async {
    debugPrint('[Audio Service] Playing background music!');
    final bool isPaused = backgroundMusicAudioPlayer.state == PlayerState.paused;
    if (!backgroundMusicAudioPlayer.isPlaying && !isPaused) {
      debugPrint('[Audio Service] Starting fresh!');
      await _playAsset(
        backgroundMusicAudioPlayer,
        'music/the_hairy_orange_spider.mp3',
      );
    } else if (isPaused) {
      debugPrint('[Audio Service] Resuming!');
      await backgroundMusicAudioPlayer.resume();
    }
  }

  @override
  Future<void> playLessonCompletionMusic() async {
    if (!effectsAudioPlayer.isPlaying) {
      await _playAsset(effectsAudioPlayer, 'effects/yay.mp3');
    }
  }

  @override
  Future<void> playLessonContent(Lesson content) async {
    if (!lessonAudioPlayer.isPlaying) {
      await _playAsset(lessonAudioPlayer, 'lessons/${content.name}.WAV');
    }
  }

  @override
  Stream<AudioServiceState> stateSubscription() {
    return backgroundMusicAudioPlayer.onPlayerStateChanged.map<AudioServiceState>((state) {
      if (state == PlayerState.playing) return AudioServiceState.playing;
      if (state == PlayerState.paused) return AudioServiceState.paused;
      return AudioServiceState.stopped;
    });
  }

  @override
  Stream<void> onComplete() => backgroundMusicAudioPlayer.onPlayerComplete;

  @override
  Future<void> playWrongChoiceEffect() async {
    if (!effectsAudioPlayer.isPlaying) {
      await _playAsset(effectsAudioPlayer, 'effects/ops.WAV');
    }
  }
}
