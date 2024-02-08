import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/config.dart';
import '../../core/utils/functions.dart';
import '../../core/widgets/game_page.dart';
import 'home_page_controller.dart';
import 'widgets/desktop_window_buttons.dart';
import 'widgets/lessons_list/lessons_list.dart';
import 'widgets/lessons_list/lessons_list_controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GamePage(
      child: SafeArea(
        child: Padding(
          padding: AppConfig.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (AppFunctions.isDesktopPlatform()) ...[
                DesktopWindowButtons(
                  onReset: () async {
                    final bool isLessonsListControllerRegistered = Get.isRegistered<LessonsListController>();
                    if (isLessonsListControllerRegistered) {
                      final LessonsListController lessonsListController = Get.find<LessonsListController>();
                      await lessonsListController.reset();
                    }
                  },
                ),
                const SizedBox(height: 16)
              ],
              const Expanded(child: LessonsList()),
            ],
          ),
        ),
      ),
    );
  }
}
