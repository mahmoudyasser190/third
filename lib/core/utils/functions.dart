import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../../services/audioplayers_audio_service.dart';
import '../../services/get_storage_cache_service.dart';
import '../bindings/initial_bindings.dart';
import '../constants/config.dart';
import '../services/audio_service.dart';
import '../services/cache_service.dart';

class AppFunctions {
  AppFunctions._();

  static Future<InitialBindings> init() async {
    _initDesktopWindow();
    final CacheService cacheService = GetStorageCacheService();
    final AudioService audioService = AudioPlayersAudioService();
    await Future.wait([cacheService.init(), audioService.init()]);
    final InitialBindings initialBindings = InitialBindings(
      cacheService: cacheService,
      audioService: audioService,
    );
    return initialBindings;
  }

  static bool isDesktopPlatform() {
    final List<bool> desktopPlatforms = [Platform.isWindows, Platform.isLinux, Platform.isMacOS];
    final bool isDesktopPlatform = desktopPlatforms.any((bool isTrue) => isTrue);
    return isDesktopPlatform;
  }

  static Future<void> _initDesktopWindow() async {
    if (isDesktopPlatform()) {
      await windowManager.ensureInitialized();
      WindowOptions windowOptions = const WindowOptions(
        fullScreen: true,
        title: AppConfig.appName,
        center: true,
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.hidden,
      );
      await windowManager.waitUntilReadyToShow(
        windowOptions,
        () async {
          await windowManager.show();
          await windowManager.focus();
        },
      );
    }
  }
}
