import 'package:flutter/material.dart';

import 'app.dart';
import 'core/bindings/initial_bindings.dart';
import 'core/utils/functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final InitialBindings initialBindings = await AppFunctions.init();

  runApp(App(initialBindings: initialBindings));
}
