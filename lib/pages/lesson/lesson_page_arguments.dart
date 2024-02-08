import 'package:flutter/widgets.dart';
import '../../core/models/lesson.dart';

class LessonPageArguments {
  final Lesson lesson;
  final Color color;
  final VoidCallback? onWillPop;

  const LessonPageArguments({
    required this.lesson,
    required this.color,
    this.onWillPop,
  });
}
