import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_ui/game_ui.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/fonts.dart';

enum LessonState { locked, completed, active }

class LessonCard extends StatelessWidget {
  final String content;
  final LessonState state;
  final Color color;
  final VoidCallback? onTap;

  const LessonCard({
    required this.content,
    required this.color,
    this.state = LessonState.locked,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const Duration animationDuration = Duration(seconds: 5);
    final bool shouldShrink = context.width < 450;
    final double cardSize = shouldShrink ? 100 : 150;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Animate(
          onComplete: (controller) => controller.loop(period: animationDuration),
          effects: state == LessonState.active
              ? const [
                  ShimmerEffect(duration: animationDuration),
                  ShakeEffect(
                    curve: Curves.easeInOut,
                    rotation: 0.03,
                    delay: Duration(seconds: 5),
                    duration: Duration(seconds: 1),
                  ),
                ]
              : null,
          child: GameCard(
            width: cardSize,
            height: cardSize,
            onTap: onTap,
            borderColor: Colors.white,
            shadows: [
              BoxShadow(
                offset: const Offset(0, 3),
                color: color.withOpacity(0.2),
              ),
            ],
            color: color,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      state == LessonState.locked ? '?' : content,
                      style: TextStyle(
                        fontSize: shouldShrink ? 70 : 100,
                        color: Colors.white,
                        fontFamily: AppFonts.digitalt,
                        height: Platform.isWindows ? null : 1,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        if (state == LessonState.completed)
          Positioned(
            top: 8,
            right: 0,
            left: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: cardSize * 0.9,
                  height: shouldShrink ? 24 : 32,
                  child: SvgPicture.asset(
                    'assets/shapes/ribbon.svg',
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
                Positioned(
                  top: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(
                      3,
                      (index) {
                        return Icon(
                          Icons.star,
                          color: color,
                          size: shouldShrink ? 12 : 18,
                        );
                      },
                    )
                      ..insert(1, const SizedBox(width: 4))
                      ..insert(3, const SizedBox(width: 4)),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
