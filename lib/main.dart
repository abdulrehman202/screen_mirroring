import 'package:flutter/material.dart';
import 'package:screen_mirroring/resources/theme_manager.dart';
import 'package:screen_mirroring/splash/splash.dart';

import 'resources/routes_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
      initialRoute: Routes.splashRoute,
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}
