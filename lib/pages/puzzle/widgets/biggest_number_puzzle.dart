import '../../../core/constants/fonts.dart';
import '../../home/widgets/lessons_list/lessons_list.dart';
import '../models/puzzle.dart';
import '../puzzle_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:game_ui/game_ui.dart';
import 'package:get/get.dart';

class BiggestNumberPuzzle extends GetView<PuzzlePageController> {
  const BiggestNumberPuzzle({super.key});

  @override
  Widget build(BuildContext context) {
    final Puzzle puzzle = controller.puzzle;
    final List<int> numbers = puzzle.numbers!;
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: numbers.map<Widget>(
          (int number) {
            final int numberIndex = numbers.indexOf(number);
            return GameCard(
              width: 100,
              height: 100,
              onTap: () {
                final bool isThereIsABiggerNumber = numbers.any((element) => element > number);
                if (isThereIsABiggerNumber) {
                  controller.playWrongChoiceEffect();
                } else {
                  controller.completePuzzle();
                }
              },
              color: LessonsList.colors[numberIndex],
              child: Text(
                number.toString(),
                style: const TextStyle(
                  fontFamily: AppFonts.digitalt,
                  color: Colors.white,
                  fontSize: 64,
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
