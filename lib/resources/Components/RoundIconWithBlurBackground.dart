import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:screen_mirroring/resources/values_manager.dart';

class RoundIconWithBlurBackground extends StatelessWidget {
  const RoundIconWithBlurBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m35),
      child: Stack(alignment: Alignment.center, children: [
        ClipOval(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
              child: const SizedBox(
                width: AppSize.s200,
                height: AppSize.s200,
              )),
        ),
        ClipOval(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: const SizedBox(
                width: AppSize.s170,
                height: AppSize.s170,
                child: Icon(Icons.monitor, color: Colors.white, size: 50),
              )),
        ),
      ]),
    );
  }
}
