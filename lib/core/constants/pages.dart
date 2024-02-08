import '../../pages/puzzle/puzzle_page.dart';
import '../../pages/puzzle/puzzle_page_bindings.dart';
import 'package:get/get.dart';

import '../../pages/home/home_page.dart';
import '../../pages/home/home_page_bindings.dart';
import '../../pages/lesson/lesson_page.dart';
import '../../pages/lesson/lesson_page_bindings.dart';
import '../../pages/splash/splash_page.dart';
import '../../pages/splash/splash_page_bindings.dart';
import 'routes.dart';

class AppPages {
  AppPages._();

  static List<GetPage> list = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      binding: SplashPageBindings(),
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.home,
      binding: HomePageBindings(),
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.lesson,
      binding: LessonPageBindings(),
      page: () => const LessonPage(),
    ),
    GetPage(
      name: AppRoutes.puzzle,
      binding: PuzzlePageBindings(),
      page: () => const PuzzlePage(),
    ),
  ];
}
