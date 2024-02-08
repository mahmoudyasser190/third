import 'package:flutter/material.dart';

import 'page_background.dart';

class GamePage extends StatelessWidget {
  final Widget child;
  final List<Color> colors;
  final bool useColorsOnlyForBackground;

  const GamePage({
    required this.child,
    this.colors = PageBackground.defaultColors,
    this.useColorsOnlyForBackground = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageBackground(
            colors: colors,
            useColorsOnly: useColorsOnlyForBackground,
          ),
          child,
        ],
      ),
    );
  }
}
