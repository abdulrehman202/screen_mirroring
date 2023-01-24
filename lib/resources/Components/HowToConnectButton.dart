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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
      ),
      onPressed: () {
        Navigator.pushNamed(context, Routes.howToConnectScreenRoute);
      },
      child: Container(
        height: AppSize.s50,
        width: AppSize.s200,
        alignment: Alignment.center,
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
    );
  }
}
