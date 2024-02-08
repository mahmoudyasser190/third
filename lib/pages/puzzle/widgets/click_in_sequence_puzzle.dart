import '../../../core/constants/fonts.dart';
import '../models/puzzle.dart';
import 'package:game_ui/core/constants/game_colors.dart';
import 'package:game_ui/game_ui.dart';
import '../puzzle_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClickInSequencePuzzle extends GetView<PuzzlePageController> {
  const ClickInSequencePuzzle({super.key});

  @override
  Widget build(BuildContext context) {
    final Puzzle puzzle = controller.puzzle;
    final List<int> sequence = puzzle.sequence!;
    return Wrap(
      runAlignment: WrapAlignment.center,
      alignment: WrapAlignment.center,
      runSpacing: 32,
      spacing: 32,
      children: List.generate(
        sequence.length,
        (int index) {
          final int currentNumber = sequence[index];
          return ObxValue<RxList<int>>(
            (rxClickedSequence) {
              final bool isClicked = rxClickedSequence.contains(currentNumber);
              return GameCard(
                width: 100,
                height: 100,
                color: isClicked ? GameColors.greenAccent : Colors.grey,
                onTap: () {
                  final List<int> sortedSequence = List.from(sequence)..sort();
                  final bool isCorrectNumber = currentNumber == sortedSequence.first || (rxClickedSequence.isNotEmpty && rxClickedSequence.last == currentNumber - 1);
                  if (isCorrectNumber) {
                    controller.addNumberToClickedSequence(currentNumber);
                    if (controller.clickedSequence.length == sequence.length) {
                      controller.completePuzzle();
                    }
                  } else {
                    controller.playWrongChoiceEffect();
                  }
                },
                child: Text(
                  currentNumber.toString(),
                  style: const TextStyle(
                    fontFamily: AppFonts.digitalt,
                    color: Colors.white,
                    fontSize: 64,
                  ),
                ),
              );
            },
            controller.clickedSequence,
          );
        },
      ),
    );
  }
}
