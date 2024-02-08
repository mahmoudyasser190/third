import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/models/lesson.dart';
import '../../../../core/widgets/error_indicator.dart';
import 'lessons_list_controller.dart';
import 'widgets/lesson_card.dart';

class LessonsList extends GetView<LessonsListController> {
  const LessonsList({super.key});

  static final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blueGrey,
    Colors.blue,
    Colors.pink,
    Colors.amber,
    Colors.purple,
    Colors.orange,
    Colors.lime,
    Colors.indigo,
    Colors.brown,
    Colors.cyan,
    Colors.lightGreen,
    Colors.deepOrangeAccent,
    Colors.black,
    Colors.tealAccent[700]!,
    Colors.purpleAccent,
    Colors.greenAccent,
    Colors.deepOrange,
    Colors.red,
    Colors.green,
    Colors.blueGrey,
    Colors.blue,
    Colors.pink,
    Colors.amber,
    Colors.purple,
    Colors.orange,
    Colors.lime,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ObxValue<Rx<LessonsListState>>(
        (rxState) {
          final LessonsListState state = rxState.value;
          if (state == LessonsListState.loading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 12,
                color: Colors.white,
              ),
            );
          }
          if (state == LessonsListState.error) return const Center(child: ErrorIndicator());
          return Center(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 16,
                alignment: WrapAlignment.spaceEvenly,
                runAlignment: WrapAlignment.center,
                runSpacing: 16,
                children: (List<Lesson>.from(Lesson.values)..removeLast()).map<Widget>(
                  (Lesson currentLesson) {
                    final Color color = colors[Lesson.values.indexOf(currentLesson)];
                    return ObxValue<Rx<Lesson>>(
                      (rxActiveLesson) {
                        final int currentLessonIndex = Lesson.values.indexOf(currentLesson);
                        final int activeLessonIndex = Lesson.values.indexOf(rxActiveLesson.value);
                        final bool isCurrentLessonCompleted = activeLessonIndex > currentLessonIndex;
                        final bool isCurrentLessonLocked = activeLessonIndex < currentLessonIndex;
                        final LessonState currentLessonState = isCurrentLessonLocked
                            ? LessonState.locked
                            : isCurrentLessonCompleted
                                ? LessonState.completed
                                : LessonState.active;
                        return LessonCard(
                          content: (currentLessonIndex + 1).toString(),
                          color: color,
                          state: currentLessonState,
                          onTap: () {
                            if (!isCurrentLessonLocked) {
                              controller.openLessonPage(
                                lesson: currentLesson,
                                color: color,
                              );
                            }
                          },
                        );
                      },
                      controller.activeLesson,
                    );
                  },
                ).toList(),
              ),
            ),
          );
        },
        controller.state,
      ),
    );
  }
}
