import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:game_ui/game_ui.dart';

class LessonAudioButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final double size;
  final bool invert;

  const LessonAudioButton({
    required this.onTap,
    required this.color,
    required this.size,
    this.invert = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = invert ? Colors.white : this.color;
    final Color secondaryColor = invert ? this.color : Colors.white;
    return Animate(
      onInit: (controller) => controller.loop(period: 5.seconds),
      effects: [ScaleEffect(curve: Curves.easeInOut, duration: 1.seconds)],
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(radius: (size / 2) * 1.05, backgroundColor: color),
          CircleAvatar(radius: (size / 2) * 1.1, backgroundColor: secondaryColor),
          GameIconButton(
            onTap: onTap,
            size: size,
            colorSet: GameIconButtonColorSet(
              background: secondaryColor,
              border: color,
              shadow: Colors.transparent.withOpacity(0),
            ),
            icon: Icon(Icons.volume_up, color: color),
          ),
        ],
      ),
    );
  }
}
