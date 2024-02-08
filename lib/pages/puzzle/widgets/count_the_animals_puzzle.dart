import 'dart:math';
import '../../../core/constants/fonts.dart';
import '../../../core/models/lesson.dart';
import '../../home/widgets/lessons_list/lessons_list.dart';
import '../models/puzzle.dart';
import '../puzzle_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_ui/game_ui.dart';
import 'package:get/get.dart';

class CountTheAnimalsPuzzle extends GetView<PuzzlePageController> {
  const CountTheAnimalsPuzzle({super.key});

  int _getRandomNumber() => (Random().nextInt(Lesson.values.length - 1)) + 1;

  @override
  Widget build(BuildContext context) {
    final Puzzle puzzle = controller.puzzle;
    final int count = puzzle.count!;
    final List<Color> shuffledColors = List.from(LessonsList.colors)..shuffle();
    final List<int> countNumbers = [count, _getRandomNumber(), _getRandomNumber()]..shuffle();
    while (countNumbers.toSet().length < 3) {
      countNumbers.clear();
      countNumbers.addAll([count, _getRandomNumber(), _getRandomNumber()]..shuffle());
    }
    return Row(
      children: [
        Expanded(
          child: Wrap(
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            runSpacing: 32,
            spacing: 32,
            children: List.generate(
              count,
              (index) {
                return SizedBox(
                  height: 100,
                  width: 100,
                  child: SvgPicture.asset('assets/animals/${puzzle.animal!.name}.svg'),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List<Widget>.generate(
            countNumbers.length,
            (index) {
              final int currentNumber = countNumbers[index];
              return GameCard(
                width: 100,
                height: 100,
                color: shuffledColors[index],
                onTap: () {
                  if (currentNumber != count) {
                    controller.playWrongChoiceEffect();
                  } else {
                    controller.completePuzzle();
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
          ),
        )
      ],
    );
  }
}
