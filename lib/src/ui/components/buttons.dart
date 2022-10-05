import 'package:flutter/material.dart';
import 'package:socialpolice/src/res/colors.dart';
import 'package:socialpolice/src/res/dimens.dart';
import 'package:socialpolice/src/res/enums.dart';
import 'package:socialpolice/src/res/icons.dart';
import 'package:socialpolice/src/res/styles.dart';
import 'package:socialpolice/src/ui/components/progress_indicator.dart';
import 'package:socialpolice/src/utils/utils.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {this.primary = true,
      this.text,
      this.icon,
      this.iconSize,
      this.textColor = Colors.white,
      this.iconColor = Colors.white,
      this.onPressed,
      this.size = ButtonSize.NORMAL,
      this.primaryColor = AppColors.colorPrimary,
      this.isLoading = false,
      this.isEnabled = true,
      this.fullButtonTextAlignment,
      this.radius = 5.0
      // this.append,
      });

  final primary;
  final String? text;
  final AppIcon? icon;
  final Color textColor;
  final Color iconColor;
  final Function? onPressed;
  final ButtonSize size;
  final double? iconSize;
  final Color primaryColor;
  // final Widget append;
  final Alignment? fullButtonTextAlignment;
  final bool isLoading;
  final bool isEnabled;
  final double radius;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = _determineTextStyle().copyWith(
      color: primary ? textColor : AppColors.colorPrimary,
    );

    return Container(
      decoration: BoxDecoration(
        boxShadow: primary
            ? [
                const BoxShadow(
                    color: AppColors.colorShadow,
                    blurRadius: 6,
                    offset: Offset(0, 3)),
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(colors: [Colors.white, Colors.white])
                .createShader(rect);
          },
          child: Material(
            color: primary
                ? ((!isLoading && isEnabled)
                    ? primaryColor
                    : primaryColor.withBlue(180).withGreen(180).withRed(180))
                : Colors.transparent,
            child: InkWell(
              onTap: !isLoading && isEnabled
                  ? () => onPressed != null ? onPressed!() : null
                  : null,
              child: Container(
                constraints: BoxConstraints(
                  minWidth: _determineMinWidth(),
                ),
                height: _determineHeight(),
                child: Container(
                  padding: _determinePadding(),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(
                      color:
                          primary ? Colors.transparent : AppColors.colorPrimary,
                      width: Dimens.dividerSmall,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: !isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: size == ButtonSize.FULL
                              ? MainAxisSize.max
                              : MainAxisSize.min,
                          children: <Widget>[
                            icon != null
                                ? icon!.drawSvg(color: iconColor)
                                : Container(),
                            SizedBox(
                              width: icon != null ? 5 : 0,
                            ),
                            _determineTextWidget(textStyle),
                          ],
                        )
                      : const SizedBox(
                          height: 20.0,
                          width: 20.0,
                          child: AppProgressIndicator(),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _determineHeight() {
    switch (size) {
      case ButtonSize.TINY:
        return 33;

      case ButtonSize.SMALL:
      case ButtonSize.MEDIUM:
        return 40;

      default:
        return 48;
    }
  }

  double _determineMinWidth() {
    switch (size) {
      case ButtonSize.NORMAL:
      case ButtonSize.COMPACT:
        return 157;
      case ButtonSize.MEDIUM:
        return 100;
      default:
        return 38;
    }
  }

  EdgeInsets _determinePadding() {
    switch (size) {
      case ButtonSize.TINY:
        return const EdgeInsets.symmetric(horizontal: Dimens.marginTiny);

      case ButtonSize.SMALL:
      case ButtonSize.ICON:
        return const EdgeInsets.symmetric(horizontal: Dimens.marginSmall);
      default:
        // if(text != null && icon != null) {
        //   return EdgeInsets.only(left: 24, right: 14);
        // }

        return const EdgeInsets.symmetric(horizontal: Dimens.marginRegular);
    }
  }

  TextStyle _determineTextStyle() {
    switch (size) {
      case ButtonSize.TINY:
        return AppStyles.textBody3;
      case ButtonSize.SMALL:
      case ButtonSize.ICON:
        return AppStyles.textBody2;
      default:
        return AppStyles.textBodyDefault;
    }
  }

  Widget _determineTextWidget(TextStyle textStyle) {
    switch (size) {
      case ButtonSize.FULL:
        return Expanded(
          child: !Utils.isEmptyOrNull(text!)
              ? Container(
                  alignment: fullButtonTextAlignment,
                  child: Text(
                    text!,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle,
                  ),
                )
              : Container(),
        );

      default:
        return !Utils.isEmptyOrNull(text!)
            ? Container(
                alignment: fullButtonTextAlignment,
                child: Text(
                  text!,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle,
                ),
              )
            : Container();
    }
  }
}
