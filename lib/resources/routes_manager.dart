import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screen_mirroring/ConnectScreen/ConnectScreen.dart';
import 'package:screen_mirroring/HowToConnectScreen/HowToConnectScreen.dart';
import 'package:screen_mirroring/QRScannerScreen/QRScannerScreen.dart';
import 'package:screen_mirroring/resources/strings_manager.dart';

import '../splash/splash.dart';

class Routes {
  static const String splashRoute = '/';
  static const String connectScreenRoute = '/ConnectScreen';
  static const String howToConnectScreenRoute = '/HowToConnectScreen';
  static const String QRScannerScreenRoute = '/QRScannerScreen';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case Routes.connectScreenRoute:
        return MaterialPageRoute(builder: (_) => const ConnectScreen());

      case Routes.howToConnectScreenRoute:
        return MaterialPageRoute(builder: (_) => const HowToConnectScreen());

      case Routes.QRScannerScreenRoute:
        return MaterialPageRoute(builder: (_) => const QRScannerScreen());

      default:
        return UnDefinedRoute();
    }
  }

  static Route<dynamic> UnDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(
                child: Text(AppStrings.noRouteFound),
              ),
            ));
  }
}
