import 'core/constants/config.dart';
import 'core/bindings/initial_bindings.dart';
import 'core/constants/pages.dart';
import 'core/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  final InitialBindings initialBindings;

  const App({required this.initialBindings, super.key});

  @override
  Widget build(BuildContext context) {
    /// Setting the [textScaleFactor] to 1 makes the app ignore the device text scaling settings.
    final MediaQueryData appMediaQuery = MediaQuery.of(context).copyWith(textScaleFactor: 1);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConfig.appName,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.list,
      defaultTransition: Transition.fade,
      initialBinding: initialBindings,
      builder: (context, child) => MediaQuery(data: appMediaQuery, child: child!),
    );
  }
}
