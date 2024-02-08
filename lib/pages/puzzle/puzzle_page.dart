import 'dart:math';
import 'widgets/click_in_sequence_puzzle.dart';
import 'widgets/count_the_animals_puzzle.dart';
import '../../core/widgets/game_page.dart';
import '../lesson/widgets/lesson_back_button.dart';
import 'models/puzzle.dart';
import 'puzzle_page_controller.dart';
import 'widgets/biggest_number_puzzle.dart';
import 'widgets/puzzle_headline.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:game_ui/game_ui.dart';
import 'package:get/get.dart';

class PuzzlePage extends GetView<PuzzlePageController> {
  const PuzzlePage({super.key});

  @override
  Widget build(BuildContext context) {
    final PuzzleType puzzleType = controller.puzzle.type;
    final Map<PuzzleType, Widget> puzzles = {
      PuzzleType.biggestNumber: const BiggestNumberPuzzle(),
      PuzzleType.countTheAnimals: const CountTheAnimalsPuzzle(),
      PuzzleType.clickInSequence: const ClickInSequencePuzzle(),
    };
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        GamePage(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: FractionallySizedBox(
                  heightFactor: 0.95,
                  widthFactor: 0.95,
                  child: ObxValue<Rx<PuzzlePageState>>(
                    (Rx<PuzzlePageState> rxState) {
                      final PuzzlePageState state = rxState.value;
                      return IgnorePointer(
                        ignoring: state == PuzzlePageState.completed,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LessonBackButton(
                              onTap: () => Get.back(),
                              color: Colors.green,
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: GameCard(
                                height: double.maxFinite,
                                width: double.maxFinite,
                                child: Padding(
                                  padding: const EdgeInsets.all(32),
                                  child: Column(
                                    children: <Widget>[
                                      PuzzleHeadline(puzzleType: puzzleType),
                                      const SizedBox(height: 16),
                                      Expanded(child: puzzles[puzzleType]!),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    controller.state,
                  ),
                ),
              ),
            ),
          ),
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
