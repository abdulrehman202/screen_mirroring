import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:screen_mirroring/resources/color_manager.dart';
import 'package:screen_mirroring/resources/routes_manager.dart';
import 'package:screen_mirroring/resources/strings_manager.dart';
import 'package:screen_mirroring/resources/styles_manager.dart';
import 'package:screen_mirroring/resources/values_manager.dart';

class StartMirroringButton extends StatelessWidget {
  const StartMirroringButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppMargin.m35),
      child: OutlinedButton(
        onPressed: () async {
          final value =
              await Navigator.pushNamed(context, Routes.QRScannerScreenRoute);
          print('value is ${value}');
        },
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                AppStrings.startMirroring,
                style: getRegularStyle(color: ColorManager.white),
              ),
              Icon(
                Icons.arrow_forward,
                color: ColorManager.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
