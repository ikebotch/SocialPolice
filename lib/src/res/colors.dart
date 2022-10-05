import 'package:flutter/material.dart';

class AppColors {
  static const Color colorPrimary = Color(0xFF1877F2);
  static const Color colorButton = Color(0xFF2F80ED);
  static const Color colorSecondary = Color(0xFF9AC2E5);
  static const Color silverGrey = Color(0xFFB4B3B3);
  static const Color colorlemonGreen = Color(0xFF18F255);

  static const Color textPrimary = Color(0xFF000000);
  static const Color textPrimaryLight = Color(0x80000000);
  static const Color textSecondary = Color(0xFF005B82);
  static const Color textAccent = Color(0xFF6B91A0);
  static const Color textDanger = Color(0xFFBA0041);

  static const Color colorBorder = Color(0x806B91A0);
  static const Color colorBorderGrey = Color(0x47707070);
  static const Color colorBackground = Color(0xFFF1F7FA);
  static const Color colorShadow = Color(0x26000000);

  static const Color colorBorderGrey1 = Color(0xFF747474);
  static const Color colorBorderGrey2 = Color(0xFFF4F8F6);
  static const Color colorBorderGrey3 = Color(0xFFF1F5F8);
  static const Color colorBorderGrey4 = Color(0xFFEEEEEE);
  static const Color colorRed1 = Color(0xFFC62416);
  static const Color colorBlue1 = Color(0xFF2F80ED);
  static const Color colorBlue2 = Color(0xFFEFF3FE);
  static const Color colorStroke = Color(0xFFFBEEFF);
  static const Color textColor1 = Color(0xFFCBCBCB);
  static const Color cardColor1 = Color(0xFFA0C1F3);

  static const Color transparent = Color(0x00000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF404040);
  static const Color grey = Color(0xFFEEECEC);
  static const Color red = Color(0xFFE35454);
  static const Color blue = Color(0xFF179BD4);
  static const Color windowBackground = Color(0xFFF8F8F8);

  static const Color borderInput = Color(0xFF99879D);

  static const gradientApp = LinearGradient(
    colors: [
      AppColors.colorPrimary,
      AppColors.colorSecondary,
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
}
