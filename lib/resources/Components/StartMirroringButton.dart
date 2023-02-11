import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:screen_mirroring/resources/color_manager.dart';
import 'package:screen_mirroring/resources/routes_manager.dart';
import 'package:screen_mirroring/resources/strings_manager.dart';
import 'package:screen_mirroring/resources/styles_manager.dart';
import 'package:screen_mirroring/resources/values_manager.dart';

class StartMirroringButton extends StatelessWidget {
  VoidCallback callback;
  StartMirroringButton({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: OutlinedButton(
        onPressed: callback,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
