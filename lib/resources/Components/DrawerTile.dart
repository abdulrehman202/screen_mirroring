import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:screen_mirroring/resources/color_manager.dart';
import 'package:screen_mirroring/resources/styles_manager.dart';
import 'package:screen_mirroring/resources/values_manager.dart';

class DrawerTile extends StatelessWidget {
  String btnText;
  VoidCallback callback;
  DrawerTile({super.key, required this.btnText, required this.callback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: AppSize.s50,
            ),
            SizedBox(
              width: AppSize.s50,
              child: IconButton(
                  icon: const Icon(Icons.arrow_downward, color: Colors.black),
                  onPressed: () {}),
            ),
            Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: Text(
                  btnText,
                  style: getRegularStyle(color: const Color(0xff000000)),
                )),
          ],
        ),
        onTap: callback);
  }
}
