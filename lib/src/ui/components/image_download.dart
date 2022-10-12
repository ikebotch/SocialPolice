import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socialpolice/src/res/colors.dart';
import 'package:socialpolice/src/res/styles.dart';
import 'package:socialpolice/src/ui/components/progress_indicator.dart';
import 'package:socialpolice/src/utils/utils.dart';

class AppImageDownload extends StatelessWidget {
  final String? url;
  final double? size;
  final BoxFit? fit;
  final double? height;
  final String? placeHolder;

  const AppImageDownload(
      {this.url, this.size, this.fit, this.height, this.placeHolder = ""});
  @override
  Widget build(BuildContext context) {
    if (Utils.isEmptyOrNull(url!)) {
      return Container(
        alignment: Alignment.center,
        width: size,
        height: size,
        color: AppColors.cardColor1, //AppColors.grey.withOpacity(0.25),
        child: Text(
          Utils.getInitails(placeHolder),
          style: AppStyles.textBody2
              .copyWith(color: AppColors.white, fontSize: 10),
          textAlign: TextAlign.center,
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: url!,
      errorWidget: (context, url, error) => Container(
          width: size,
          height: size,
          color: AppColors.grey.withOpacity(0.25),
          child: Text(Utils.getInitails(placeHolder)) //Icon(Icons.error),
          ),
      // placeholder: (context, url) => Container(
      //   width: size,
      //   height: size,
      //   color: AppColors.grey,
      //   child: Icon(Icons.error),
      // ),
      progressIndicatorBuilder: (context, url, progress) {
        return Container(
            width: size,
            height: size,
            color: AppColors.grey.withOpacity(0.25),
            child: const AppProgressIndicator());
      },
      fit: fit,
      width: size,
      height: height,
    );
  }
}
