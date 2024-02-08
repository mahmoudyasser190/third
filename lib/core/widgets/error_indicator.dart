import 'package:flutter/material.dart';

import '../constants/fonts.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      ':(',
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: AppFonts.digitalt,
        color: Colors.white,
        fontSize: 24,
      ),
    );
  }
}
