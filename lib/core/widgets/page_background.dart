import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageBackground extends StatelessWidget {
  final List<Color> colors;
  final bool useColorsOnly;
  final List<double>? stops;

  const PageBackground({
    this.colors = defaultColors,
    this.useColorsOnly = false,
    this.stops,
    super.key,
  });

  static const List<Color> defaultColors = <Color>[Color(0xffA659FE), Color(0xff6F53FD)];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          stops: stops,
        ),
      ),
      child: useColorsOnly
          ? null
          : SvgPicture.asset(
              'assets/shapes/background.svg',
              fit: BoxFit.fill,
            ),
    );
  }
}
