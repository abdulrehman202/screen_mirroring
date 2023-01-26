import 'dart:async';

import 'package:flutter/material.dart';
import 'package:screen_mirroring/resources/assets_manager.dart';
import 'package:screen_mirroring/resources/color_manager.dart';

import '../resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Timer _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  void _goNext() {
    Navigator.pushReplacementNamed(context, Routes.connectScreenRoute);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorManager.black,
        child: Center(
          child: Image.asset(ImagePath.logo),
        ),
      ),
    );
  }
}
