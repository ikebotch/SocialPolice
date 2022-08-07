import 'package:flutter/material.dart';
import 'package:socialpolice/src/res/colors.dart';

import 'package:flutter_svg/flutter_svg.dart';

class AppIcon {
  final String value;
  const AppIcon(this.value);

  Widget draw({Color color = AppColors.colorPrimary, double? size}) =>
      drawSvg(color: color, size: size!);

  Widget drawSvg({Color? color, double? size}) {
    return SvgPicture.asset(
      value,
      semanticsLabel: 'icon',
      width: size ?? 24,
      height: size ?? 24,
      color: color,
    );
  }

  static const AppIcon home = AppIcon('assets/images/svg/home.svg');
  static const AppIcon search = AppIcon('assets/images/svg/search.svg');
  static const AppIcon messageNav = AppIcon('assets/images/svg/message.svg');
  static const AppIcon profile = AppIcon('assets/images/svg/profile.svg');
  static const AppIcon cap = AppIcon('assets/images/svg/cap.svg');
  static const AppIcon rotate = AppIcon('assets/images/svg/rotate.svg');
  static const AppIcon flashOff = AppIcon('assets/images/svg/flash_off.svg');
  static const AppIcon gallery = AppIcon('assets/images/svg/pictures.svg');
  static const AppIcon camera = AppIcon('assets/images/svg/camera.svg');
  static const AppIcon close = AppIcon('assets/images/svg/x.svg');
}
