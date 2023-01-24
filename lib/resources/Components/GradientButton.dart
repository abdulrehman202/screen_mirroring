import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:screen_mirroring/resources/color_manager.dart';
import 'package:screen_mirroring/resources/styles_manager.dart';

class GradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback callback;
  const GradientButton(
      {super.key, required this.buttonText, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          gradient: GradientManager.buttonGradient,
        ),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 40,
        child: TextButton(
            onPressed: callback,
            child: Text(
              buttonText,
              style: getRegularStyle(color: ColorManager.white),
            )));
  }
}
