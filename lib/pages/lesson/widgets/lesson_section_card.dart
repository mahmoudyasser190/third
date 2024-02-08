import 'package:flutter/material.dart';
import 'package:game_ui/game_ui.dart';
import 'package:get/get.dart';

import '../../../core/models/lesson.dart';
import 'lesson_audio_button.dart';

class LessonSectionCard extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback onAudioButtonTapped;
  final Color color;
  final Widget content;
  final bool invertAudioButton;
  final Color backgroundColor;
  final bool showAudioButton;

  const LessonSectionCard({
    required this.lesson,
    required this.color,
    required this.onAudioButtonTapped,
    required this.content,
    required this.backgroundColor,
    this.invertAudioButton = false,
    this.showAudioButton = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool shouldSwitchToColumn = context.width < 780;
    final List<Widget> children = [
      Expanded(flex: 4, child: content),
      if (shouldSwitchToColumn) const SizedBox(height: 16),
      if (!shouldSwitchToColumn) const SizedBox(width: 16),
      if (showAudioButton)
        Expanded(
          child: FittedBox(
            child: LessonAudioButton(
              onTap: onAudioButtonTapped,
              color: color,
              invert: invertAudioButton,
              // Just a placeholder value
              size: 48,
            ),
          ),
        ),
    ];
    return GameCard(
      width: double.maxFinite,
      height: double.maxFinite,
      padding: const EdgeInsets.all(32),
      color: backgroundColor,
      onTap: () {
        if (!showAudioButton) onAudioButtonTapped();
      },
      child: shouldSwitchToColumn
          ? Column(
              mainAxisSize: MainAxisSize.max,
              children: children,
            )
          : Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
    );
  }
}
