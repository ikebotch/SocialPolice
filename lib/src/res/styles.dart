import 'package:flutter/material.dart';
import 'package:socialpolice/src/res/colors.dart';
import 'package:socialpolice/src/res/dimens.dart';

class AppStyles {
  static const TextStyle textTitleDefualt = TextStyle(
    color: AppColors.textPrimary,
    fontSize: Dimens.textBig,
    fontWeight: FontWeight.bold,
    // fontFamily: 'Nunito_Sans',
  );
  static const TextStyle textTitleLight = TextStyle(
    color: AppColors.colorPrimary,
    fontSize: Dimens.textSmall,
    fontWeight: FontWeight.w500,
    // fontFamily: 'Nunito_Sans',
  );

  static const TextStyle textBodyDefault = TextStyle(
    color: AppColors.textPrimary,
    fontSize: Dimens.textRegular,
    fontWeight: FontWeight.w400,
    // fontFamily: 'Nunito_Sans',
  );

  // 15 R
  static const TextStyle textBody2 = TextStyle(
    color: AppColors.textPrimary,
    fontSize: Dimens.textSmall,
    fontWeight: FontWeight.w400,
    // fontFamily: 'Nunito_Sans',
  );

  // 15 R
  static const TextStyle textBody2PublicSans = TextStyle(
    color: AppColors.textPrimary,
    fontSize: Dimens.textSmall,
    fontWeight: FontWeight.w400,
    // Public Sans
  );

  // 14 R
  static const TextStyle textBody3 = TextStyle(
    color: AppColors.textPrimary,
    fontSize: Dimens.textSmall,
    fontWeight: FontWeight.w400,
    // fontFamily: 'Nunito_Sans',
  );

  static const TextStyle textTitleRegular = TextStyle(
    color: AppColors.textPrimary,
    fontSize: Dimens.textRegular,
    fontWeight: FontWeight.bold,
    // fontFamily: 'Nunito_Sans',
  );

  static const TextStyle textTitle1 = TextStyle(
    color: AppColors.textPrimary,
    fontSize: Dimens.textRegular,
    fontWeight: FontWeight.w700,
    // fontFamily: 'Nunito_Sans',
  );

// SilverGrey 12
  static const TextStyle textStyle12 = TextStyle(
    fontSize: 12,
    color: AppColors.silverGrey,
    // fontFamily: 'Nunito_Sans',
  );
}
