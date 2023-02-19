import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:screen_mirroring/resources/theme_manager.dart';
import 'resources/routes_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //0F7D399DF68E1891CADFB7E81D0824DA
  MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: ['0F7D399DF68E1891CADFB7E81D0824DA']));
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
