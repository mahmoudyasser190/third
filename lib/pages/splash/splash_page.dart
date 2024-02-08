import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_ui/core/constants/game_colors.dart';
import 'package:get/get.dart';

import '../../core/widgets/game_page.dart';
import 'splash_page_controller.dart';

class SplashPage extends GetView<SplashPageController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GamePage(
      useColorsOnlyForBackground: true,
      child: SizedBox.expand(
        child: Stack(
          children: [
            Positioned.fill(
              child: FractionallySizedBox(
                heightFactor: 0.5,
                widthFactor: 0.5,
                child: Animate(
                  effects: const [
                    ShimmerEffect(duration: Duration(seconds: 1)),
                    ShimmerEffect(delay: Duration(seconds: 1), duration: Duration(seconds: 1)),
                  ],
                  child: SvgPicture.asset('assets/logo.svg'),
                ),
              ),
            ),
            if (context.height >= 360)
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Animate(
                  effects: const [ScaleEffect(curve: Curves.easeInOut)],
                  child: const Text(
                    'Loading...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Digitalt',
                      fontSize: 25,
                      color: GameColors.yellowAccent,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
