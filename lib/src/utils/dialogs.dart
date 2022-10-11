import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialpolice/src/model/stream_progress_response.dart';
import 'package:socialpolice/src/res/colors.dart';
import 'package:socialpolice/src/res/dimens.dart';
import 'package:socialpolice/src/res/enums.dart';
import 'package:socialpolice/src/res/styles.dart';
import 'package:socialpolice/src/ui/components/buttons.dart';
import 'package:socialpolice/src/ui/components/progress_indicator.dart';
import 'package:socialpolice/src/utils/utils.dart';

class Dialogs {
  /// Pop-ups
  Future<void> presentScreen(BuildContext context, Widget view,
      {bool dismissible = true}) async {
    // checks (dont show dialog if out of context)
    if (context == null) {
      return Future.error('Out of context!');
    }

    return showDialog<void>(
        context: context,
        barrierDismissible: dismissible,
        builder: (BuildContext ctx) {
          return SimpleDialog(
            contentPadding: const EdgeInsets.all(Dimens.marginRegular),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            children: <Widget>[view],
          );
        });
  }

  Future<void> showMessage(BuildContext context, String message,
      {bool dismiss = true, String? dismissLabel, String? header}) async {
    // checks (dont show dialog if out of context)
    if (context == null) {
      return Future.error('Out of context!');
    }
    String headerMsg;
    if (header == null) {
      headerMsg = "Something went wrong";
    } else {
      headerMsg = header;
    }
    return showDialog<void>(
        context: context,
        barrierDismissible: dismiss,
        builder: (BuildContext ctx) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            children: <Widget>[
              header != null
                  ? Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 0,
                            top: Dimens
                                .marginRegular), //EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: Text(
                          headerMsg,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.black),
                        ),
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimens.marginRegular,
                    left: 20,
                    right:
                        20), //EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Center(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: FlatButton(
                    textColor: AppColors.white,
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text(
                      !Utils.isEmptyOrNull(dismissLabel!) ? dismissLabel : "Ok",
                      style: AppStyles.textBody2.copyWith(
                          color: AppColors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

// header not applied here
  Future<void> showNoOptionDialog(BuildContext context, String message,
      {bool dismissible = true}) async {
    // checks (dont show dialog if out of context)
    if (context == null) {
      return Future.error('Out of context!');
    }

    return showDialog<void>(
        context: context,
        barrierDismissible: dismissible,
        builder: (BuildContext ctx) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimens.marginRegular,
                    horizontal: Dimens.marginRegular),
                child: Center(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        });
  }

// not apllied here too umm
  Future<bool?> showSingleOptionDialog(BuildContext context, String message,
      String actionLabel, Function() action,
      {bool dismissable = false}) async {
    return showDialog<bool>(
        context: context,
        barrierDismissible: dismissable,
        builder: (BuildContext ctx) {
          if (Platform.isIOS) {
            return CupertinoAlertDialog(
              title: Text(message,
                  style: AppStyles.textBodyDefault.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              content: Container(),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.of(ctx).pop();
                    action();
                  },
                  child: Text(
                    !Utils.isEmptyOrNull(actionLabel) ? actionLabel : "Yes",
                    style: AppStyles.textBody2.copyWith(
                        color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          }
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: AppStyles.textBodyDefault.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: Dimens.marginMedium),
                        child: FlatButton(
                          child: Text(
                            actionLabel.toUpperCase(),
                            style: AppStyles.textBody2.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            action();
                            // Navigator.of(ctx).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

// header not applied here
  Future<bool?> showSingleOptionUpdateDialog(BuildContext context,
      String message, String actionLabel, Function() action,
      {bool dismissable = false, bool update = false}) async {
    BackButtonInterceptor.add((stopDefaultButtonEvent, routeInfo) => true);
    return showDialog<bool>(
        context: context,
        barrierDismissible: dismissable,
        builder: (BuildContext ctx) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: Dimens.marginMedium),
                        child: AppButton(
                          text: actionLabel.toUpperCase(),
                          size: ButtonSize.MEDIUM,
                          textColor: AppColors.white,
                          primaryColor: AppColors.colorPrimary,
                          onPressed: () {
                            if (update == false) {
                              Navigator.of(ctx).pop();
                            }
                            action();
                            // Navigator.of(ctx).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<bool?> showDoubleOptionDialog(
      BuildContext context, Function(bool option) action,
      {String? actionLabel,
      String? cancelLabel,
      String? header,
      Color? positiveColor}) async {
    String headerMsg;
    if (header == null) {
      headerMsg = "Something went wrong";
    } else {
      headerMsg = header;
    }
    return showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext ctx) {
          if (Platform.isIOS) {
            return CupertinoAlertDialog(
              title: header != null
                  ? Text(headerMsg,
                      style: AppStyles.textBodyDefault.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16))
                  : Container(),
              content: Container(),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    action(false);
                  },
                  child: Text(
                    !Utils.isEmptyOrNull(cancelLabel!) ? cancelLabel : "No",
                    style: AppStyles.textBody2.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.of(ctx).pop();
                    // return not cancelled
                    action(true);
                  },
                  child: Text(
                    !Utils.isEmptyOrNull(actionLabel!) ? actionLabel : "Yes",
                    style: AppStyles.textBody2.copyWith(
                        color: positiveColor ?? Colors.blueAccent,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          }
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    header != null
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 0,
                                top: Dimens
                                    .marginRegular), //EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                            child: Text(headerMsg,
                                style: AppStyles.textBodyDefault.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          )
                        : Container(),
                    const SizedBox(height: Dimens.marginRegular),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimens.marginSmall),
                      child: GestureDetector(
                        child: Text(
                          !Utils.isEmptyOrNull(cancelLabel!)
                              ? cancelLabel
                              : "No",
                          style: AppStyles.textBody2.copyWith(
                              color: AppColors.colorPrimary,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.of(ctx).pop();
                          // return cancelled
                          action(false);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimens.marginSmall),
                      child: GestureDetector(
                        child: Text(
                          !Utils.isEmptyOrNull(actionLabel!)
                              ? actionLabel
                              : "Yes",
                          style: AppStyles.textBody2.copyWith(
                              color: AppColors.colorPrimary,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.of(ctx).pop();
                          // return not cancelled
                          action(true);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  bool _backButtonInterceptor(bool stopButtonEvent) {
    return true;
  }

  Future<void> showProgressDialogMessage<T>(
      BuildContext context, String message) async {
    BackButtonInterceptor.add((stopDefaultButtonEvent, routeInfo) => true);
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: AppColors.white.withOpacity(1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Dimens.marginRegular,
                      bottom: Dimens.marginMedium,
                    ),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: AppStyles.textBodyDefault
                          .copyWith(color: AppColors.black),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    child: const AppProgressIndicator(),
                  ),
                ],
              ),
            ],
          );
        })
      ..then((_) {
        BackButtonInterceptor.removeAll();
      })
      ..catchError((_) {
        BackButtonInterceptor.removeAll();
      });
  }
// Future<FutureProgressResponse<T>> showProgressDialogMessage<T>(BuildContext context, String message, [Future<T> Function() action]) async {
//   BackButtonInterceptor.add((stopDefaultButtonEvent, routeInfo) => true);
//   return showDialog<FutureProgressResponse<T>>(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {

//       if(action != null){
//         var resp = action.call();
//         final response = FutureProgressResponse<T>();
//         response.status = true;
//         response.responseObject = resp;
//         BackButtonInterceptor.removeAll();
//         Navigator.of(context, rootNavigator: true).pop(response);
//       }

//       return SimpleDialog(
//         backgroundColor: AppColors.white.withOpacity(1),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//         children: <Widget>[
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.max,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.only(
//                   top: Dimens.marginRegular,
//                   bottom: Dimens.marginMedium,
//                 ),
//                 child: Text(
//                   message,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Container(
//                 width: 20,
//                 height: 20,
//                 padding: EdgeInsets.only(
//                   top: Dimens.marginMedium,
//                   bottom: Dimens.marginRegular,
//                 ),
//                 child: RentmeProgressIndicator(),
//               ),
//             ],
//           ),
//         ],
//       );
//     }
//   )..then((_) {
//     BackButtonInterceptor.removeAll();
//   })
//   ..catchError((_) {
//     BackButtonInterceptor.removeAll();
//   });
// }

//header not needed here
  Future<StreamProgressResponse<T>?> showStreamProgressDialogMessage<T>(
      BuildContext context, String message, Stream stream) async {
    BackButtonInterceptor.add((stopDefaultButtonEvent, routeInfo) => true);
    return showDialog<StreamProgressResponse<T>>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext subCtx) {
          stream.listen((data) {
            final response = StreamProgressResponse<T>();
            response.status = true;
            response.responseObject = data;
            BackButtonInterceptor.removeAll();
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.of(subCtx, rootNavigator: true).pop(response);
            });
          }).onError((err) {
            Utils.log('ERRROR ON STREAM PROGRESS $err');

            final response = StreamProgressResponse<T>();
            response.status = false;
            response.errorMessage = err.toString();
            BackButtonInterceptor.removeAll();
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.of(subCtx, rootNavigator: true).pop(response);
            });
          });

          if (Platform.isIOS) {
            return CupertinoAlertDialog(
              title: Text(message,
                  style: AppStyles.textBodyDefault.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16)),
              content: const AppProgressIndicator(),
            );
          }
          return SimpleDialog(
            backgroundColor: AppColors.white.withOpacity(1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Dimens.marginRegular,
                      bottom: Dimens.marginMedium,
                    ),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: AppStyles.textBodyDefault.copyWith(
                          color: AppColors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    child: const AppProgressIndicator(),
                  ),
                ],
              ),
            ],
          );
        })
      ..then((_) {
        BackButtonInterceptor.removeAll();
      })
      ..catchError((_) {
        BackButtonInterceptor.removeAll();
      });
  }

  showInSnackBar(
      String message, BuildContext context, GlobalKey<ScaffoldState> key) {
    key.currentState!.showSnackBar(SnackBar(
        content: Text(
      message,
      style: AppStyles.textBody2
          .copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
    )));
  }

  Future<bool?> setProfilePic(
      BuildContext context, Function(CameraType option) action,
      {String? actionLabel, String? cancelLabel, String? header}) async {
    String headerMsg;
    if (header == null) {
      headerMsg = "Something went wrong";
    } else {
      headerMsg = header;
    }
    return showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext ctx) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    header != null
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 0,
                                top: Dimens
                                    .marginRegular), //EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                            child: Text(headerMsg,
                                style: AppStyles.textBodyDefault.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24)),
                          )
                        : Container(),
                    const SizedBox(height: Dimens.marginRegular),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimens.marginSmall),
                      child: GestureDetector(
                        child: Text(
                          !Utils.isEmptyOrNull(cancelLabel!)
                              ? cancelLabel
                              : "Take photo",
                          style: AppStyles.textBody2.copyWith(
                              color: AppColors.colorPrimary,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.of(ctx).pop();
                          // return cancelled
                          action(CameraType.CAMERA);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimens.marginSmall),
                      child: GestureDetector(
                        child: Text(
                          !Utils.isEmptyOrNull(actionLabel!)
                              ? actionLabel
                              : "Choose photo",
                          style: AppStyles.textBody2.copyWith(
                              color: AppColors.colorPrimary,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.of(ctx).pop();
                          // return not cancelled
                          action(CameraType.GALLERY);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
