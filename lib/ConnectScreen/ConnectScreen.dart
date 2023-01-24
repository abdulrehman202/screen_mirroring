import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:screen_mirroring/resources/Clippers/Wavy.dart';
import 'package:screen_mirroring/resources/Components/HowToConnectButton.dart';
import 'package:screen_mirroring/resources/Components/RoundIconWithBlurBackground.dart';
import 'package:screen_mirroring/resources/Components/StartMirroringButton.dart';
import 'package:screen_mirroring/resources/color_manager.dart';
import 'package:screen_mirroring/resources/routes_manager.dart';
import 'package:screen_mirroring/resources/strings_manager.dart';
import 'package:screen_mirroring/resources/styles_manager.dart';
import 'package:screen_mirroring/resources/values_manager.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: GradientManager.gradient,
        ),
        child: Stack(alignment: Alignment.center, children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const RoundIconWithBlurBackground(),
              const StartMirroringButton(),
              Flexible(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: ClipPath(clipper: Wavy(), child: const HowToConnectButton()),
          ),
        ]),
      ),
    );
  }
}
