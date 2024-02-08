import 'dart:async';

import 'package:get/get.dart';

import '../../core/constants/routes.dart';

class SplashPageController extends GetxController {
  late final Timer timer;

  @override
  void onInit() {
    timer = Timer(const Duration(seconds: 2), openHomePage);
    super.onInit();
  }

  void openHomePage() => Get.offNamed(AppRoutes.home);

  @override
  void onClose() {
    if (timer.isActive) timer.cancel();
    super.onClose();
  }
}
