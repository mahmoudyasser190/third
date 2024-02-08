import 'package:flutter/material.dart';
import 'package:game_ui/game_ui.dart';
import 'package:get/get.dart';

class LessonBackButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;

  const LessonBackButton({required this.onTap, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: context.width < 450 ? (32 / 48) : 1,
      child: GameIconButton(
        onTap: onTap,
        colorSet: GameIconButtonColorSet(
          background: color,
          border: Colors.white,
          shadow: color.withOpacity(0.15),
        ),
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
