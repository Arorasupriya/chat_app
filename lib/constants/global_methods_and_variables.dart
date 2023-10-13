import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppVariables {
  ///Variables
  static late String title;
  static late bool isDark;
}

hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

bool getThemeByMQAndThemeContext(BuildContext context) {
  //var mediaQueryData = MediaQuery.of(context); //for getting platform Brightness
  var getThemeData =
      Theme.of(context); //use for getting App theme will be dark and light
  bool isDark = getThemeData.brightness == Brightness.dark;
  return isDark;
}

getThemeColorAccordingLitDrk(BuildContext context, bool isDark) {
  if (isDark) {
    ColorConstant.bgColor = ColorConstant.mattBlackColor;
    ColorConstant.textOnBGColor = Colors.white;
    ColorConstant.secondaryColor = Colors.white;
    ColorConstant.secondaryTextColor = ColorConstant.mattBlackColor;
    ColorConstant.iconColorSM = Colors.blue;
    ColorConstant.textThirdColor = Colors.blueGrey.shade600;
    AppVariables.title = "Dark";
  } else {
    ColorConstant.bgColor = Colors.white;
    ColorConstant.textOnBGColor = ColorConstant.mattBlackColor;
    ColorConstant.secondaryColor = ColorConstant.mattBlackColor;
    ColorConstant.secondaryTextColor = Colors.white;
    ColorConstant.iconColorSM = Colors.yellow;
    ColorConstant.textThirdColor = Colors.blueGrey.shade600;
    AppVariables.title = "Light";
  }
}

//DateTime Format
String convertStringToDateTimeObjectToString(String myDateTime) {
  var formatTime = DateTime.parse(myDateTime);
  var formatedDateTime =
      "${formatTime.year}-${formatTime.month}-${formatTime.day}";
  print("new date $formatedDateTime");
  return formatedDateTime;
}
