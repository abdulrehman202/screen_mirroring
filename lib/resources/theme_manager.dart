import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main colors of app
    primaryColor: ColorManager.black,
    primaryColorLight: ColorManager.lightGrey,
    primaryColorDark: ColorManager.grey,
    splashColor: ColorManager.white,

    //App bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle:
          getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
    ),

    textTheme: TextTheme(
      subtitle1:
          getMediumStyle(color: ColorManager.white, fontSize: FontSize.s14),
      caption: getRegularStyle(color: ColorManager.white),
      bodyText1: getRegularStyle(color: ColorManager.white),
    ),
  );
}
