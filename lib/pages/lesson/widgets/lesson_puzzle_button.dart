import 'package:flutter/material.dart';
import 'package:game_ui/game_ui.dart';

class LessonPuzzleButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;

  const LessonPuzzleButton({
    required this.color,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GameIconButton(
      onTap: onTap,
      colorSet: GameIconButtonColorSet(
        background: color,
        border: Colors.white,
        shadow: color.withOpacity(0.15),
      ),
      icon: const Icon(
        Icons.question_mark_outlined,
        color: Colors.white,
      ),
    );
  }
}
