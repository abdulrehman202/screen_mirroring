import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:screen_mirroring/resources/Clippers/Wavy.dart';
import 'package:screen_mirroring/resources/Components/DrawerTile.dart';
import 'package:screen_mirroring/resources/Components/HowToConnectButton.dart';
import 'package:screen_mirroring/resources/Components/RateUsDialog.dart';
import 'package:screen_mirroring/resources/Components/RoundIconWithBlurBackground.dart';
import 'package:screen_mirroring/resources/Components/StartMirroringButton.dart';
import 'package:screen_mirroring/resources/Components/StopMirroringButton.dart';
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
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: customDrawer(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Screen Mirroring'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: GradientManager.gradient,
        ),
        child: Stack(alignment: Alignment.center, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
              ),
              const HowToConnectButton(),
              const RoundIconWithBlurBackground(),
              const StopMirroringButton(),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: ClipPath(
                clipper: Wavy(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: AppSize.s450,
                  color: ColorManager.grey,
                )),
          ),
          const Positioned(
            bottom: AppMargin.m20,
            child: HowToConnectButton(),
          ),
        ]),
      ),
    );
  }

  customDrawer() {
    return Container(
      color: Colors.transparent,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Stack(alignment: Alignment.center, children: [
          Positioned(
            left: -50,
            child: ClipOval(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: const BoxDecoration(
                  gradient: GradientManager.blueGradient,
                ),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DrawerTile(
                          btnText: 'Rate Us',
                          callback: () {
                            showRatingDialog();
                          },
                        ),
                        DrawerTile(
                          btnText: 'Privacy Policy',
                          callback: () {},
                        ),
                        DrawerTile(
                          btnText: 'More Apps',
                          callback: () {},
                        ),
                        DrawerTile(
                          btnText: 'Share App',
                          callback: () {},
                        ),
                      ]),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ClipOval(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.black,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: ColorManager.white,
                  onPressed: () {
                    _scaffoldKey.currentState?.closeDrawer();
                  },
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  showRatingDialog() {
    showDialog(context: context, builder: (builder) => const RateUsDialog());
  }
}
