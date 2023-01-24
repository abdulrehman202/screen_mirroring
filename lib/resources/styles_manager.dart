import 'package:flutter/cupertino.dart';
import 'font_manager.dart';

TextStyle _getTextSTyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: color);
}

//regular style
TextStyle getRegularStyle(
    {double fontSize = FontSize.s14, required Color color}) {
  return _getTextSTyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.regular, color);
}

//light style
TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextSTyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.light, color);
}

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextSTyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.medium, color);
}
