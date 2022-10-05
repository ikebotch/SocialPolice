import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRoute {
  static navigatePush(
      {BuildContext? context,
      Widget? page,
      String? name,
      bool isScale = false,
      PageTransitionType transitionType = PageTransitionType.scale}) {
    return Navigator.push(
      context!,
      PageTransition(
        type:
            transitionType, //isScale ? PageTransitionType.scale : PageTransitionType.rightToLeft,
        alignment: Alignment.bottomCenter,
        settings: RouteSettings(
          name: name,
        ),
        child: page!,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  static navigateRemoveUntil(BuildContext context, Widget page,
      {String? name}) {
    // Utils.logAll('NAVIGATION => to ${page.toString()}');
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.bottomCenter,
            settings: RouteSettings(
              name: name,
            ),
            child: page),
        (route) => route.isFirst);
  }

  static navigateReplace(BuildContext context, Widget page, {String? name}) {
    // Utils.logAll('NAVIGATION => to ${page.toString()}');
    Navigator.pushReplacement(
      context,
      PageTransition(
          type: PageTransitionType.rightToLeft,
          alignment: Alignment.bottomCenter,
          settings: RouteSettings(
            name: name,
          ),
          child: page),
    );
  }

  static pop(BuildContext context, [result, rootNavigator = false]) {
    // Navigator.pop(context, result);
    Navigator.of(context, rootNavigator: rootNavigator).pop(result);
  }
}
