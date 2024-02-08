import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/config.dart';
import '../../core/constants/fonts.dart';
import '../../core/models/lesson.dart';
import '../../core/widgets/game_page.dart';
import '../home/widgets/lessons_list/widgets/lesson_card.dart';
import 'lesson_page_controller.dart';
import 'widgets/lesson_back_button.dart';
import 'widgets/lesson_section_card.dart';
import 'widgets/white_board_section/white_board_section.dart';

class LessonPage extends GetView<LessonPageController> {
  const LessonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = controller.color;
    final Lesson lesson = controller.lesson;
    final Widget puzzleCard = LessonSectionCard(
      lesson: lesson,
      color: color,
      backgroundColor: Colors.white,
      invertAudioButton: true,
      onAudioButtonTapped: controller.openPuzzlePage,
      content: FittedBox(
        child: Text(
          '?',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: AppFonts.digitalt, color: color),
        ),
      ),
    );
    final Widget lessonContentCard = LessonSectionCard(
      lesson: lesson,
      color: color,
      backgroundColor: color,
      onAudioButtonTapped: () => controller.playLessonContent(),
      content: FittedBox(
        child: Text(
          lesson.number.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: AppFonts.digitalt, color: Colors.white),
        ),
      ),
    );
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ObxValue<Rx<LessonState>>(
          (rxLessonState) {
            return IgnorePointer(
              ignoring: rxLessonState.value == LessonState.completed,
              child: GamePage(
                child: SafeArea(
                  child: Padding(
                    padding: AppConfig.pagePadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LessonBackButton(
                          color: controller.color,
                          onTap: () {
                            Get.back();
                            controller.onWillPop?.call();
                          },
                        ),
                        const SizedBox(height: 16),
                        if (context.width > 600)
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(child: lessonContentCard),
                                      const SizedBox(height: 32),
                                      Expanded(child: puzzleCard),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 32),
                                const Expanded(flex: 2, child: WhiteBoardSection())
                              ],
                            ),
                          ),
                        if (context.width <= 600) ...[
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(child: lessonContentCard),
                                const SizedBox(width: 16),
                                Expanded(child: puzzleCard),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Expanded(flex: 2, child: WhiteBoardSection()),
                        ],
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          controller.lessonState,
        ),
        ConfettiWidget(
          confettiController: controller.confettiController,
          blastDirection: pi / 2,
          numberOfParticles: 100,
          minBlastForce: 10,
          blastDirectionality: BlastDirectionality.explosive,
        ),
      ],
    );
  }
}
