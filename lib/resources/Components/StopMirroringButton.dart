import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:screen_mirroring/resources/color_manager.dart';
import 'package:screen_mirroring/resources/routes_manager.dart';
import 'package:screen_mirroring/resources/strings_manager.dart';
import 'package:screen_mirroring/resources/styles_manager.dart';
import 'package:screen_mirroring/resources/values_manager.dart';

class StopMirroringButton extends StatelessWidget {
  const StopMirroringButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppMargin.m35),
      width: MediaQuery.of(context).size.width * 0.6,
      child: ElevatedButton(
        onPressed: () async {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.close_outlined,
                color: ColorManager.white,
              ),
              Text(
                AppStrings.stopMirroring,
                style: getRegularStyle(color: ColorManager.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
