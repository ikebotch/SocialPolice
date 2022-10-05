import 'package:flutter/material.dart';

class Dimens {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }

  // Get the proportionate height as per screen size
  static double getProportionateScreenHeight(double inputHeight) {
    double screenHeight = Dimens.screenHeight;
    // 812 is the layout height that designer use
    return (inputHeight / 812.0) * screenHeight;
  }

  static double getProportionateScreenWidth(double inputWidth) {
    double screenWidth = Dimens.screenWidth;
    // 375 is the layout width that designer use
    return (inputWidth / 375.0) * screenWidth;
  }

  static const double marginSuperLarge = 100.0;
  static const double marginHuge = 80.0;
  static const double marginXXLarge = 70.0;
  static const double marginXLarge = 46.0;
  static const double marginLarge = 40.0;
  static const double marginBig = 32.0;
  static const double marginRegular = 20.0;
  static const double marginMedium = 16.0;
  static const double marginSmall = 10.0;
  static const double marginTiny = 4.0;
  static const double marginTopFromSafe = 37.0;

  static const double textExtraLarge = 46.0;
  static const double textLarge = 40.0;
  static const double textHuge = 27.0;
  static const double textBig = 21.0;
  static const double textRegular = 16.0;
  static const double textMedium = 15.0;
  static const double textSmall = 14.0;
  static const double textTiny = 12.0;

  static const double dividerLarge = 10.0;
  static const double dividerBig = 8.0;
  static const double dividerRegular = 4.0;
  static const double dividerSmall = 2.0;
  static const double dividerLine = 1.0;
  static const double dividerTiny = 0.5;

  static const double borderRadius = 3.0;

  static const double dialogWidth = 400;
}
