import '../../../core/constants/fonts.dart';
import '../models/puzzle.dart';
import 'package:flutter/material.dart';

class PuzzleHeadline extends StatelessWidget {
  final PuzzleType puzzleType;

  const PuzzleHeadline({required this.puzzleType, super.key});

  @override
  Widget build(BuildContext context) {
    late String text;
    if (puzzleType == PuzzleType.biggestNumber) {
      text = 'Choose the biggest number';
    } else if (puzzleType == PuzzleType.clickInSequence) {
      text = 'Click the numbers in the correct sequence';
    } else {
      text = 'Count the animals';
    }
    return Text(
      text,
      style: const TextStyle(
        fontSize: 50,
        color: Colors.black,
        fontFamily: AppFonts.digitalt,
      ),
    );
  }
}
