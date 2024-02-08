import 'package:flutter/material.dart';
import 'package:game_ui/game_ui.dart';
import 'package:get/get.dart';

class CompleteLessonButton extends StatelessWidget {
  final VoidCallback onTap;

  const CompleteLessonButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: context.width > 500 ? 1 : (32 / 48),
      child: GameIconButton(
        onTap: onTap,
        icon: const Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}
