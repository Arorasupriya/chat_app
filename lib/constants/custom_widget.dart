import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:flutter/material.dart';

InputDecoration myDecoration({
  required String mHintText,
  required String mLabelText,
  double bRadius = 21.0,
  Color bColor = Colors.blueGrey,
  Color mFillColor = Colors.white12,
  bool isFilled = false,
  IconData? preFixIconName,
  IconData? surFixIconName,
  VoidCallback? onSurFixIconTap,
  Color mySuffixIconColor = Colors.blue,
}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    //new add 9 nov
    suffixIconColor: mySuffixIconColor,
    hintText: mHintText,
    hintStyle: mTextStyle12(mFontColor: Colors.black),
    //ColorConstant. textOnBGColor
    label: Text(mLabelText),
    labelStyle: mTextStyle12(mFontColor: Colors.black),
    //ColorConstant.textOnBGColor
    fillColor: mFillColor,
    filled: isFilled,
    prefixIcon: preFixIconName != null ? Icon(preFixIconName) : null,
    suffixIcon: surFixIconName != null
        ? InkWell(onTap: onSurFixIconTap, child: Icon(surFixIconName))
        : null,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(bRadius),
        borderSide: BorderSide(color: bColor)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(bRadius),
      borderSide: BorderSide(color: bColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(bRadius),
      borderSide: BorderSide(color: bColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(bRadius),
      borderSide: BorderSide(color: bColor),
    ),
  );
}

Widget hSpacer({double mHeight = 11}) {
  return SizedBox(
    height: mHeight,
  );
}

Widget wSpacer({double mWidth = 11}) {
  return SizedBox(
    width: mWidth,
  );
}

Widget customElevatedButton(
    {required VoidCallback onTap,
    required String? title,
    IconData? iconName,
    bool isChildText = true,
    Color? buttonBGColor,
    double? mElevation,
    double? mButtonHeight,
    double? mButtonWidth,
    double? bRadius}) {
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(bRadius!)),
        backgroundColor: buttonBGColor,
        padding: !isChildText ? EdgeInsets.zero : null,
        elevation: mElevation,
        minimumSize: Size(mButtonWidth!, mButtonHeight!)),
    child: isChildText
        ? Text(
            title!,
            style: mTextStyle12(mFontColor: ColorConstant.greyColor),
          )
        : Icon(iconName),
  );
}
