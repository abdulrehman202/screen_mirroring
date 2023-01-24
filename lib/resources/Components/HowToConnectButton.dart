import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:screen_mirroring/resources/color_manager.dart';
import 'package:screen_mirroring/resources/routes_manager.dart';
import 'package:screen_mirroring/resources/strings_manager.dart';
import 'package:screen_mirroring/resources/styles_manager.dart';
import 'package:screen_mirroring/resources/values_manager.dart';

class HowToConnectButton extends StatelessWidget {
  const HowToConnectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: AppSize.s450,
      color: ColorManager.black,
      child: OutlinedButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.howToConnectScreenRoute);
        },
        child: Center(
          child: Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.symmetric(vertical: AppMargin.m35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.howToConnect,
                  style: getRegularStyle(color: ColorManager.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
